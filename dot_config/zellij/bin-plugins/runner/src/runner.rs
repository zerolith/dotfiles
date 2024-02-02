use std::env;

use crate::{action::Action, ui, zellij};

struct Args {
    session: String,
    layout: Option<String>,
}

impl Args {
    fn from_args() -> Option<Self> {
        let mut args = env::args();

        match args.nth(1) {
            None => None,
            Some(session) => match args.nth(2) {
                None => Some(Self {
                    session,
                    layout: None,
                }),
                Some(layout) => Some(Self {
                    session,
                    layout: Some(layout),
                }),
            },
        }
    }
}

pub(crate) fn init() {
    let input = Args::from_args();

    let action = match zellij::list_sessions() {
        Err(error) => Action::Exit(Err(error)),
        Ok(sessions) => match (input, sessions.as_slice()) {
            (Some(Args { session, layout }), &[]) => Action::CreateNewSession {
                session,
                layout,
                dir: None,
            },
            (None, &[]) => ui::new_session_prompt(sessions),
            (Some(Args { session, layout }), _) => {
                if sessions.contains(&session) {
                    Action::AttachToSession(session)
                } else {
                    Action::CreateNewSession {
                        session,
                        layout,
                        dir: None,
                    }
                }
            }
            (None, _) => ui::action_selector(sessions),
        },
    };

    action.exec()
}

pub(crate) fn switch() {
    let action = match zellij::list_sessions() {
        Err(error) => Action::Exit(Err(error)),
        Ok(sessions) => match sessions.as_slice() {
            &[] => ui::new_session_prompt(sessions),
            _ => ui::action_selector(sessions),
        },
    };

    action.exec()
}
