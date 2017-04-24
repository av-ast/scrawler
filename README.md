# Scr(eenshots) (cr)awler
Web-pages crawler &amp; screenshots maker

To start Scrawler:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Provisioning:

    $ ansible-galaxy install abaez.docker
    $ cd deploy
    $ ansible-playbook web.yml
