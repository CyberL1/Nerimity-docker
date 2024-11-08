if ! pnpm prisma migrate status; then
  echo Database outdated, syncing...
  pnpm prisma migrate deploy
else
  echo Database up to date, skipping...
fi

if [ $DEV_MODE = "true" ]; then
  pnpm dev
else
  pnpm run build
  pnpm start
fi
