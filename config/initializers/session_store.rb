Rails.application.config.session_store :cookie_store, key: '_healthy_session', expire_after: 10.years, session_store: Rails.env.production?
