# Bipa Infra API Documentation

API documentation for **Bipa Infra** - Crypto as a Service for Brazilian businesses.

## Overview

This documentation is built with [Mintlify](https://mintlify.com) and covers the complete Bipa Infra API:

- **Customers** - Manage end-users (individuals and businesses)
- **Pix** - Brazil's instant payment system integration
- **Quotes** - Real-time currency conversion quotes
- **Trading** - 24/7 cryptocurrency trading
- **On-chain** - USDT and Bitcoin blockchain transfers
- **Lightning** - Instant Bitcoin payments via Lightning Network
- **Balances** - Account balances and transaction history

## Local Development

Install the [Mintlify CLI](https://www.npmjs.com/package/mintlify):

```bash
npm i -g mintlify
```

Run the development server:

```bash
mintlify dev
```

The documentation will be available at `http://localhost:3000`.

## Structure

```
docs/
├── introduction.mdx        # Platform overview
├── authentication.mdx      # API authentication
├── errors.mdx              # Error handling
├── webhooks.mdx            # Webhook integration
├── rate-limits.mdx         # Rate limiting
├── api-reference/
│   ├── customers/          # Customer management
│   ├── pix/                # Pix payments
│   ├── quotes/             # Currency quotes
│   ├── trading/            # Trading operations
│   ├── onchain/            # On-chain transfers
│   ├── lightning/          # Lightning Network
│   └── balances/           # Balances & transactions
├── docs.json               # Mintlify configuration
└── logo/                   # Bipa logos
```

## API Base URL

```
https://api.bipa.app/v1
```

## Authentication

All API requests require Bearer token authentication:

```bash
curl https://api.bipa.app/v1/customers \
  -H "Authorization: Bearer sk_live_xxxxxxxxxxxx"
```

## Resources

- [Bipa Infra](https://produtos.bipa.app/crypto-as-a-service) - Product page
- [Dashboard](https://dashboard.bipa.app) - API key management
- [Support](mailto:suporte@bipa.app) - Technical support

## License

Copyright © 2024 Bipa. All rights reserved.
