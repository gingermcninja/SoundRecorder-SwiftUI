This project started as a simple audio sound board for my 10 year old niece. I decided to expand its functionality so that the user can record their own sounds and assign them to buttons on the audio board. This functionality is still very much a work in progress.

I got somewhat sidelined with this app as I decided to use it to investigate and test various CI/CD tools and processes, utilizing github actions, fastlane and fastlane match.

Jira board: https://gingermcninja.atlassian.net/jira/software/projects/SR/boards/77

Notes:
The automated build system is dependent on Github secrets. The values are as follows:
MATCH_PERSONAL_ACCESS_TOKEN: The personal access token of the Match repo used to store the fastlane match certificates and provisioning profiles. See [Github profile]->Settings->Developer settings->Personal access tokens->Tokens (classic). In Base64 format.
MATCH_PASSWORD: Used in the fastlane match process to encrypt the certificates. Can probably be arbitrary but where's the fun (or security) in that?
APP_STORE_CONNECT_API_KEY: Encoded in base64, this is used to access app store connect. See App Store Connect -> Users and Access -> Integrations
APP_STORE_CONNECT_ISSUER_ID: See above. Not base64 encoded
APP_STORE_CONNECT_KEY_ID: See above. Not base64 encoded
KEYCHAIN_PASSWORD: Used to create a temporary keychain that will be utilized by fastlane match

