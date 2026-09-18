# Partner guides

Standalone pages written for a specific partner, deployed outside the Mintlify
site. They live here because they are documentation, but they are **not** part of
`docs.json` and never render as pages on the docs site.

| Guide | Audience | Served at |
|---|---|---|
| `ponte-sandbox-ptbr` | Projeto Ponte originator partners, pt-BR | https://guia.agentispay.co |

## Why these are separate

Projeto Ponte's partner surface is deliberately vendor-neutral: partners integrate
against `agentispay.co` and their staff are not told which institution is behind
the API. A guide for them therefore cannot live on the Bipa-branded docs site, name
Bipa, or link to it. `ponte-sandbox-ptbr` names no vendor and makes no external
request except Google Fonts.

Keep it that way when editing. `grep -i bipa partner-guides/ponte-sandbox-ptbr/public/index.html`
should return nothing.

## Deploying

Each guide is an assets-only Cloudflare Worker on the Bipa Enterprise account:

```sh
cd partner-guides/ponte-sandbox-ptbr
npx wrangler@4 deploy
```

The Worker and its custom domain are **not** managed by Terraform — see the
follow-up note on [infra#1583](https://github.com/bipa-app/infra/pull/1583).
