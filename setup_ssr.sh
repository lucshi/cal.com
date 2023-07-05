bash modify.sh
npx prettier --write apps/web/components/PageWrapper.tsx

bash startdb.sh

yarn
yarn workspace @calcom/prisma db-migrate
yarn workspace @calcom/prisma db-deploy

yarn build

# replace files
cp replace_files/next.js ./node_modules/next/dist/server/next.js
cp replace_files/next-server.js ./node_modules/next/dist/server/next-server.js
