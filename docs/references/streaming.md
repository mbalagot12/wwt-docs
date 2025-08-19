# Streaming Telemetry

## Multiple Instances

```yaml
daemon TerminAttr
    exec /usr/bin/TerminAttr 
    -disableaaa

    -cvaddr=apiserver.cv-staging.corp.arista.io:443
    -cvauth=token-secure,/tmp/cv-onboarding-token
    -cvvrf=MGMT

    -cvopt instructor.addr=apiserver.cv-staging.corp.arista.io:443
    -cvopt instructor.auth=token-secure,/tmp/instructor_pod
    -cvopt instructor.vrf=MGMT

    -taillogs
    -cvproxy=
    -cvauth=certs,/persist/secure/ssl/terminattr/primary/certs/client.crt,/persist/secure/ssl/terminattr/primary/keys/client.key
    -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata
```
