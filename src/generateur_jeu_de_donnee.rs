use rand::{Rng, thread_rng};
use chrono::{NaiveDate, NaiveTime};
use mysql::{Pool, prelude::*};

pub fn generateur_de_donnee() -> Result<(), mysql::Error> {
    let url = "mysql://root:@localhost:3306/yoga";
    let pool = Pool::new(url)?;
    let mut rng = thread_rng();
    let n_users = 10;
    let n_courses = 20;
    let firstnames = vec!["Jean", "Marie", "Pierre", "Claire", "Julien", "Laura", "Lucie", "Thomas", "Anne", "Sophie"];
    let lastnames = vec!["Dupont", "Martin", "Dubois", "Lefèvre", "Moreau", "Girard", "Blanc", "Leclerc", "Lecomte", "Rousseau"];
    let courses = vec!["Yoga doux", "Hatha yoga", "Vinyasa yoga", "Ashtanga yoga", "Yoga prénatal", "Yin yoga", "Yoga nidra", "Kundalini yoga", "Jivamukti yoga", "Anusara yoga"];

    for i in 1..=n_users {
        let mut firstname = firstnames[rng.gen_range(0..firstnames.len())];
        let mut lastname = lastnames[rng.gen_range(0..lastnames.len())];
        let mut pseudo = format!("user{}", i);
        let mut mail = format!("{}{}@example.com", firstname.to_lowercase(), lastname.to_lowercase());
        let mut password = format!("{:x}", rng.gen::<u128>());

        // Vérifier si les données générées sont uniques dans la base de données
        let mut conn = pool.get_conn()?;
        while conn.exec_first::<bool, _, _>("SELECT EXISTS(SELECT 1 FROM utilisateurs WHERE mail=? OR pseudo=?);", (&mail, &pseudo))?.unwrap() {
            firstname = firstnames[rng.gen_range(0..firstnames.len())];
            lastname = lastnames[rng.gen_range(0..lastnames.len())];
            pseudo = format!("user{}", i);
            mail = format!("{}{}@example.com", firstname.to_lowercase(), lastname.to_lowercase());
            password = format!("{:x}", rng.gen::<u128>());
        }

        let stmt = format!("INSERT INTO utilisateurs (firstname, lastname, pseudo, mail, password) VALUES ('{}', '{}', '{}', '{}', '{}')", firstname, lastname, pseudo, mail, password);
        conn.exec_drop(&stmt,())?;
    }
    for i in 1..=n_courses {
        let nom_cours = courses[rng.gen_range(0..courses.len())];
        let instructeur = format!("Instructeur {}", rng.gen_range(1..=5));
        let date_cours = NaiveDate::from_ymd(2022, rng.gen_range(1..=12), rng.gen_range(1..=28));
        let heure_cours = NaiveTime::from_hms(rng.gen_range(8..=20), 0, 0);
        let duree_cours = rng.gen_range(60.. 121);

        let stmt = format!("INSERT INTO cours (nom_cours, instructeur, date_cours, heure_cours, duree_cours) VALUES ('{}', '{}', '{}', '{}', {})", nom_cours, instructeur, date_cours, heure_cours, duree_cours);
        let mut conn = pool.get_conn()?;
        conn.exec_drop(&stmt,())?;
    }

    Ok(())
}
pub fn afficher_les_données() {
    todo!()
}
