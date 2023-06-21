if ! pnpm prisma migrate status; then
  echo Database outdated, syncing...
  pnpm prisma:migrate_deploy
else
  echo Database up to date, skipping...
fi

pnpm dev
