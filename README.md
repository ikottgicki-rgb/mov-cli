# mov-cli

ani-cli but for movies and TV shows. Search, browse, and stream directly in your terminal.

**Linux only.**

## Install

```bash
git clone https://github.com/YOUR_USERNAME/mov-cli
cd mov-cli
bash install.sh
```

## Usage

```bash
mov-cli inception
mov-cli "breaking bad"
mov-cli  # opens a search prompt
```

Search → pick a result → pick season/episode (for TV) → pick subtitles (optional) → plays in mpv.

## Dependencies

- `mpv` — video player
- `fzf` — fuzzy selection UI
- `python3` + `requests` + `playwright` — networking and browser fallback

The install script handles all of these.
