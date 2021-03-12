#To run vault in dev:
docker-compose -f docker-compose.dev.yml up --build -d

#Verify the server is running (you can also open the ui: http://0.0.0.0:8201/ui/vault/auth?with=token)
export VAULT_TOKEN="00000000-0000-0000-0000-000000000000"
export VAULT_ADDR='http://0.0.0.0:8201'
./vault status

#Enable a new path (aka secrets engine)
./vault secrets enable -path=testpath kv
./vault secrets list
#To create a secret
./vault kv put testpath/namesecret target=valuesecret
#To read a secret
./vault kv get testpath/namesecret
