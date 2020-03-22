use std::env;

use futures::{Future, stream::Stream};

use telebot::Bot;
use telebot::functions::*;

use aalto_tg_bot::handlers;
use aalto_tg_bot::db::init::init_db;

fn format_result(response: &str) -> String {
    return format!("Результат:\n{}", response);
}

fn main() {
    init_db();

    let mut bot = Bot::new(&env::var("TELEGRAM_BOT_TOKEN_AALTO").unwrap()).update_interval(200);

    let help = bot.new_cmd("/help")
        .and_then(|(bot, msg)| {
            bot.message(msg.chat.id, format_result(handlers::help::handle(&msg).as_str())).send()
        })
        .for_each(|_| Ok(()));

    // Register a reply command which answers a message
    let person = bot.new_cmd("/person")
        .and_then(|(bot, msg)| {
            bot.message(msg.chat.id, format_result(handlers::person::handle(&msg).as_str())).send()
        })
        .for_each(|_| Ok(()));

    let room = bot.new_cmd("/room")
        .and_then(|(bot, msg)| {
            bot.message(msg.chat.id, format_result(handlers::room::handle(&msg).as_str())).send()
        })
        .for_each(|_| Ok(()));

    let handlers = help.join(person).join(room);

    bot.run_with(handlers);
}