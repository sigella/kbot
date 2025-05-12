# kbot

A Telegram bot for controlling traffic light signals using GPIO pins on a Raspberry Pi.

## Prerequisites

- Go 1.16 or later
- Docker (optional, for containerization)
- Telegram Bot Token (set as TELE_TOKEN environment variable)
- Required Go packages:
  - github.com/spf13/cobra
  - github.com/stianeikeland/go-rpio
  - gopkg.in/telebot.v3

## Installation

1. Clone the repository:
```bash
git clone https://github.com/sigella/kbot.git
cd kbot
```
2. Create your own telegram bot using the [instruction](https://core.telegram.org/bots/tutorial#introduction)

3. Set up your Telegram Bot Token:
```bash
export TELE_TOKEN="your_telegram_bot_token"
```

## Usage

Start the bot:
```bash
./kbot start
```

### Available Commands
- `/start hello` - Get a greeting from the bot

## Development

The project uses Cobra for CLI command management and go-rpio for GPIO control.

### Project Structure

- `cmd/` - Contains the main command implementations
  - `kbot.go` - Main bot implementation and traffic light control
  - `root.go` - Root command configuration
  - `version.go` - Version command implementation

## License

This project is licensed under the MIT License - see the LICENSE file for details.