#To run vault in dev:
docker-compose -f docker-compose.dev.yml up --build -d

#Verify the server is running (you can also open the ui: http://0.0.0.0:8201/ui/vault/auth?with=token)
export VAULT_TOKEN="00000000-0000-0000-0000-000000000000"
export VAULT_ADDR='http://0.0.0.0:8201'
./vault status
./vault secrets list

#Test with Key Vaule secrets engine
#./vault secrets enable -path=testpath kv
#./vault kv put testpath/namesecret target=valuesecret
#./vault kv get testpath/namesecret

#Creds for Terraform
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

#Enable AWS secrets engine (aka secrets engine, aka virtual filesystem, aka path) 
#Using the TF IAM vault user (not root for TF above)
./vault secrets enable -path=awsvfs aws
export VAULT_AWS_ACCESS_KEY_ID=
export VAULTAWS_SECRET_ACCESS_KEY=

./vault write awsvfs/config/root access_key=$VAULT_AWS_ACCESS_KEY_ID secret_key=$VAULTAWS_SECRET_ACCESS_KEY region=us-east-1
./vault write awsvfs/roles/vault_kinesis_ro_role role_arns=arn:aws:iam::<ACC_NUM>:role/kinesis_ro_role credential_type=assumed_role
./vault read awsvfs/creds/vault_kinesis_ro_role