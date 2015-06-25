Stamp Rally
================

Getting Started
---------------

```
$ cp .env.sample .env
$ cp config/database.yml.sample config/database.yml
```

### .env

```
OMNIAUTH_PROVIDER_KEY=YOUR-KEY # remotty app key
OMNIAUTH_PROVIDER_SECRET=YOUR-SECRET # remotty app secret
OMNIAUTH_SITE=http://remotty.dev # remottyのURL
HOST_URL=http://stamp-rally.dev # アプリのURL)
REMOTTY_GROUP_ID=15 # remotty連携の投稿先グループID
MASTER_NAMES=wancha,chee,nori  # スタンプを押す人の名前(remotty での名前)
```

