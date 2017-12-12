# Codelab: Speaking with a Webpage

This is a sample solution for the codelab "Speaking with a Webpage".

## Step 0 - Configure Compute Engine

Install Java and Maven:

    sudo apt-get update
    sudo apt-get install -y maven openjdk-8-jdk

The maven jetty plugin listens for http and https connections on ports `8080`
and `8443` by default. Open them up on the Compute Engine firewall:

    gcloud compute firewall-rules create dev-ports \
        --allow=tcp:8080,tcp:8443 \
        --source-ranges=0.0.0.0/0

## Step 1

Create a webapp on Google Compute Engine that can serve static javascript, a
static `index.html`, and a dynamic controller.

When using `getUserInput` to access microphone input, browsers require the
connection to be `https`. Configure the app for https - for development
purposes, a self-signed certificate suffices.

Generate a self-signed SSL cert for now:

    keytool -genkey -alias jetty -keyalg RSA \
        -keystore src/main/resources/jetty.keystore \
        -storepass secret -keypass secret -dname "CN=localhost"

Then run:

    cd 01-hello-https/
    mvn clean jetty:run

## Step 2

Use the WebAudio API on the frontend to get microphone data.

## Step 3

Stream the raw audio data from the client to the server using WebSockets.

When on an `https` webpage, websocket connections are required to be secure
`wss`.

## Step 4

Use the Speech API to stream transcriptions of speech to the client.

## Disclaimer

This is not an official Google product
