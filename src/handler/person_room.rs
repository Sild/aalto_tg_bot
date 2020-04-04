use crate::util;
use crate::db::model::{Person, PersonRole, Room, PersonRoom};
use dict::DictIface;
use std::borrow::Borrow;


fn help(prefix: &str) -> String {
    return format!("{}
Использование:
/person_room help
/person_room link tg_login='' room_num=''
/person_room unlink tg_login='' room_num=''
    ", prefix);
}

fn link_unlink_impl(args: &Vec<&str>, remove: bool) -> String {
    let kwargs = util::parse_kwargs(args.join(" ").as_str());

    let tg_login: String = kwargs.get("tg_login").unwrap_or(&String::new()).to_string();
    let room_num: u32 = kwargs.get("room_num").unwrap_or(&String::new()).to_string().parse().unwrap_or(0);

    if tg_login.is_empty() || room_num == 0 {
        return String::from("Ошибка: некорректные параметры");
    }
    let person = Person::select_by_tg_login(tg_login.as_str());
    let rooms = Room::select_by_room_nums(&vec!(room_num));
    if person.is_none() {
        return format!("Не нашли пользователя с tg_login='{}'", tg_login);
    }
    let person = person.unwrap();
    if rooms.len() < 1 {
        return format!("Не нашли квартиру с номером='{}'", room_num);
    }
    let mut person_rooms = PersonRoom::select_by_room_ids(&vec!(rooms[0].id));
    for pr in &mut person_rooms {
        if pr.person_id == person.id {
            if (remove) {
                pr.delete();
                return String::from("Удалено.");
            } else {
                return format!("Такая связь уже существует");
            }
        }
    }
    if remove {
        return String::from("Связь не найдена");
    }
    let mut person_room = PersonRoom {
        id: 0,
        person_id: person.id,
        room_id: rooms[0].id
    };
    person_room.save();
    return format!("Сохранено: {} (tg_login: '{}', квартира: {})", person_room.to_string(), person.tg_login, rooms[0].num);
}

pub fn handle(msg: &telebot::objects::Message) -> String {
    let arguments: Vec<&str> = msg.text.as_ref().unwrap().split(" ").collect();
    let who = match msg.from.as_ref().unwrap().username.as_ref() {
        Some(x) => Person::select_by_tg_login(x),
        _ => None,
    };
    if who.is_none() || who.unwrap().role != PersonRole::Admin {
        return format!("Ошибка: пользователь tg_login='{}' не найден или не является администратором.", msg.from.as_ref().unwrap().username.as_ref().unwrap_or(&String::new()));
    }
    return match arguments[0] {
        "help" => help(""),
        "link" => link_unlink_impl(arguments.as_ref(), false),
        "unlink" => link_unlink_impl(arguments.as_ref(), true),
        _ => help("Unknown command")
    };
}