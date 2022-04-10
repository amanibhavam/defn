#!/usr/bin/env bash

case "${1}" in
   install)
      linkerd install --identity-trust-anchors-file "$2-ca.crt" --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply -f -
      ;;
   add-anchor)
      linkerd upgrade --identity-trust-anchors-file both.crt --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply -f -
      ;;
   restart)
      kubectl -n linkerd rollout restart deployments
      ;;
   change-identity)
      linkerd upgrade --identity-trust-anchors-file both.crt --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply -f -
      ;;
   only-anchor)
      linkerd upgrade --identity-trust-anchors-file "$2-ca.crt" --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply -f -
      ;;
   recreate)
      kubectl delete ns linkerd
      rm -f v*.crt v*.key
      "$0" new-ca v1
      "$0" install v1
      ;;
   new-ca)
      shift
      for a in "$@"; do
         step certificate create root.linkerd.cluster.local "$a-ca.crt" "$a-ca.key" --not-after=8700h --no-password --insecure --profile root-ca --force
         step certificate create identity.linkerd.cluster.local "$a-identity.crt" "$a-identity.key" --not-after=8700h --no-password --insecure --profile intermediate-ca --ca "$a-ca.crt" --ca-key "$a-ca.key" --force
      done
      cat v*-ca.crt > both.crt
      ;;
   v*)
      "$0" new-ca "$1"
      "$0" add-anchor "$1"
      "$0" restart
      "$0" change-identity "$1"
      "$0" only-anchor "$1"
      ;;
   rotate)
      "$0" "v$(date +%s)"
      ;;
   *)
      echo recreate
      echo rotate vX
      exit 0
      ;;
esac

sleep 10
linkerd check --proxy
kubectl -n linkerd get pods
