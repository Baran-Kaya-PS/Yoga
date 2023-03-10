mod generateur_jeu_de_donnee;

use std::error::Error as StdError;
use rand::Rng;
use std::io;
use std::process::exit;
use generateur_jeu_de_donnee::*;
use mysql::{prelude::Queryable, Pool, Error};
fn main() -> Result<(), Box<dyn StdError>> {
    let url = "mysql://root:@localhost:3306/yoga";
    let mut pool = Pool::new(url)?;
    let mut conn = pool.get_conn().unwrap();
    println!("Connexion établie");
    println!("1. Se connecter");
    println!("2. Quitter le programme");
    let mut choice = String::new();
    io::stdin()
        .read_line(&mut choice)
        .expect("Erreur");
    match choice.trim().parse::<u32>() {
        Ok(1) => {
            let mut choice = String::new();
            println!("quel est votre identifiant ?");
            io::stdin()
                .read_line(&mut choice)
                .expect("Err");
            seConnecter(&choice);
        }
        _ => {
            exit(0);
        }
    }
    Ok(())
}


