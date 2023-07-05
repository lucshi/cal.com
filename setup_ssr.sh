bash startdb.sh


yarn config set httpProxy {httpProxy}
yarn config set httpsProxy {httpProxy}

yarn
yarn workspace @calcom/prisma db-migrate
yarn workspace @calcom/prisma db-deploy
npx prettier --write apps/web/components/PageWrapper.tsx

yarn build
