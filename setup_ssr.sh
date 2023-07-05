bash modify.sh
npx prettier --write apps/web/components/PageWrapper.tsx

bash startdb.sh

yarn
yarn workspace @calcom/prisma db-migrate
yarn workspace @calcom/prisma db-deploy

yarn build
