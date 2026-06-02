# Personal Vault

A minimal Ruby on Rails app for storing **notes** and **credentials** locally. Each user has a private vault; entry titles and bodies are **encrypted at rest** in SQLite.

## Quick start

```bash
cd personal_vault
bin/setup --skip-server
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000), create an account, and add entries. **Be sure to remember your passwords**, as there is not any password reset function within this program.

Requirements: Ruby 3.4+ (see `.ruby-version`), Bundler, SQLite.

## What “secure” means here

| Layer | Approach |
|--------|----------|
| **Authentication** | Email + password (`bcrypt` via `has_secure_password`). Sessions are stored in **HttpOnly**, **signed**, **SameSite=Lax** cookies. |
| **Authorization** | Each vault entry belongs to a user. Controllers only load `Current.user.vault_entries` so users can't read each other’s data. |
| **Encryption at rest** | `title` and `body` use [Active Record Encryption](https://guides.rubyonrails.org/active_record_encryption.html). Raw SQLite rows do not contain plaintext secrets. |
| **Logs** | Sensitive params (`password`, `body`, etc.) are filtered from logs. |

### What this app does *not* provide

- **End-to-end encryption** — the server can decrypt entries when you view them. Anyone with your `config/master.key` and database file can decrypt data.
- **Password recovery** — no mailer is configured; keep your password safe.
- **Hardware security / 2FA** — not included by design (minimal scope).

Treat this as a **local, single-user-style vault**, more of a demo than a true production password manager.

## Stack

- Rails 8.1
- SQLite
- Propshaft CSS

## Encryption keys

`bin/setup` creates `config/encryption_keys.yml` (gitignored). **Back up this file with your SQLite database.** Without it, encrypted entries cannot be read.

To regenerate (only on a fresh database):

```bash
rm config/encryption_keys.yml db/*.sqlite3
bin/rails encryption:setup
bin/rails db:prepare
```

## Development

```bash
bin/rails console
bin/rails routes
bin/ci
```
