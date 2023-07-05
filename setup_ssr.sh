#!/bin/bash
# Copyright (C) <2023-2023> Intel Corporation
# SPDX-License-Identifier: MIT

# Modify Server .env
file=./.env.example
target=./.env

nextauth=`openssl rand -base64 32`
calendso_encryption_key=`openssl rand -base64 24`
user='unicorn_user'
pass='magical_password'
database_host='localhost:5432'
postgres_db='calendso'

sed -i -e "s|^CALENDSO_ENCRYPTION_KEY=.*|CALENDSO_ENCRYPTION_KEY='$calendso_encryption_key'|" \
       -e "s|^NEXTAUTH_SECRET=.*|NEXTAUTH_SECRET='$nextauth'|" \
       -e "s|^DATABASE_URL=.*|DATABASE_URL=\"postgresql://$user:$pass@$database_host/$postgres_db\"|" $file

cp $file $target

# Change the font from google
wget -O Inter-Latin.woff2 https://fonts.gstatic.com/s/inter/v12/UcCO3FwrK3iLTeHuS_fvQtMwCp50KnMw2boKoduKmMEVuLyfAZ9hiA.woff2
mv Inter-Latin.woff2 apps/web/fonts

cd apps/web/components

comment1='import { Inter } from "next/font/google";'
sed -i "s#$comment1#//$comment1#g" PageWrapper.tsx

# Replace the line that starts with const interFont with the new code
new_code="const interFont = localFont({ src: \"..\/fonts\/Inter-Latin.woff2\", variable: \"--font-inter\", preload: true, display: \"swap\",});"
sed -i "s/^const interFont.*/$new_code/" PageWrapper.tsx
cd ../../..

cd /calcom

# start up postgresql
service postgresql start

# create user
# sudo -u postgres createuser $POSTGRES_USER -P
sudo -u postgres psql -c \
    "CREATE USER unicorn_user WITH SUPERUSER PASSWORD 'magical_password';"

# alter user attributes for creating db
sudo -u postgres psql -c "ALTER USER unicorn_user CREATEDB;"

yarn config set httpProxy http://proxy-dmz.intel.com:912/
yarn config set httpsProxy http://proxy-dmz.intel.com:912/
yarn

npx prettier --write apps/web/components/PageWrapper.tsx

# replace files
cp ssr_files/next.js ./node_modules/next/dist/server/next.js
cp ssr_files/next-server.js ./node_modules/next/dist/server/next-server.js

yarn workspace @calcom/prisma db-migrate
yarn workspace @calcom/prisma db-deploy

yarn build


