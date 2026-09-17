bash -c '
set -euo pipefail
umask 077
API_KEY="REPLACE_WITH_YOUR_SANDBOX_API_KEY"
FIXTURE=$(curl --silent --show-error --fail-with-body \
  "https://api-sandbox.agentispay.co/migrations/sandbox-fixture?scenario=document_recapture" \
  --header "X-API-Key: $API_KEY")
REQUEST=$(cat <<JSON
{
  "external_id": $(printf "%s" "$FIXTURE" | jq ".external_id"),
  "tax_id": { "type": "cpf", "value": $(printf "%s" "$FIXTURE" | jq ".tax_id.value") },
  "email": $(printf "%s" "$FIXTURE" | jq ".email"),
  "phone": $(printf "%s" "$FIXTURE" | jq ".phone"),
  "consents": {
    "data_sharing": {
      "accepted_at": $(printf "%s" "$FIXTURE" | jq ".consents.data_sharing.accepted_at"),
      "ip": "192.0.2.1", "locale": "pt-BR", "user_agent": "PartnerSandbox/1.0",
      "document_version": "sandbox-v1",
      "document_digest_sha256": "0000000000000000000000000000000000000000000000000000000000000000"
    },
    "terms_of_service": {
      "accepted_at": $(printf "%s" "$FIXTURE" | jq ".consents.terms_of_service.accepted_at"),
      "ip": "192.0.2.1", "locale": "pt-BR", "user_agent": "PartnerSandbox/1.0",
      "document_version": "sandbox-v1",
      "document_digest_sha256": "0000000000000000000000000000000000000000000000000000000000000000"
    }
  },
  "kyc": {
    "level": "full",
    "selfie_file_url": $(printf "%s" "$FIXTURE" | jq ".kyc.selfie_file_url"),
    "document_files": [
      { "side": "front", "file_url": $(printf "%s" "$FIXTURE" | jq ".kyc.document_files[0].file_url") },
      { "side": "back", "file_url": $(printf "%s" "$FIXTURE" | jq ".kyc.document_files[1].file_url") }
    ]
  },
  "address": {
    "zip_code": "58051340", "street": "Rua Luiz Primola", "number": "180",
    "district": "Bancarios", "city": "Joao Pessoa", "state": "PB", "country": "BR"
  },
  "balances": [
    {"asset": "BTC", "quantity": "1000000"},
    {"asset": "USDT", "quantity": "1000000"}
  ],
  "sandbox": $(printf "%s" "$FIXTURE" | jq ".sandbox + {monthly_income_cents: \"1200000\"}")
}
JSON
)
printf "%s\n" "$REQUEST" | jq . | tee 03-recapture.request.json
curl --silent --show-error --fail-with-body \
  --output 03-recapture.response.json \
  --write-out "HTTP %{http_code}\n" \
  "https://api-sandbox.agentispay.co/migrations" \
  --header "X-API-Key: $API_KEY" \
  --header "Content-Type: application/json" \
  --data-binary @03-recapture.request.json
jq . 03-recapture.response.json
'
