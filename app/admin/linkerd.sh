#!/usr/bin/env bash

server="$(basename "$(pwd)")"

case "${1}" in
   install)
      linkerd install --context "${server}" --identity-trust-anchors-file "$2-ca.crt" --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl --context "${server}" apply -f -
      sleep 10; linkerd check --context "${server}" --proxy
      linkerd viz install --context "${server}" | kubectl apply --context "${server}" -f -
      sleep 10; linkerd viz check --context "${server}"
      linkerd check --context "${server}" --proxy
      ;;
   add-anchor)
      linkerd upgrade --context "${server}" --identity-trust-anchors-file trust-anchors.crt --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply --context "${server}" -f -
      ;;
   restart)
      kubectl --context "${server}" -n linkerd rollout restart deployments
      sleep 10; linkerd check --context "${server}" --proxy
      ;;
   change-identity)
      linkerd upgrade --context "${server}" --identity-trust-anchors-file trust-anchors.crt --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply --context "${server}" -f -
      ;;
   only-anchor)
      linkerd upgrade --identity-trust-anchors-file "$2-ca.crt" --identity-issuer-certificate-file "$2-identity.crt" --identity-issuer-key-file "$2-identity.key" | kubectl apply -f -
      ;;
   recreate)
      linkerd viz uninstall --context "${server}"
      linkerd uninstall --context "${server}"
      "$0" install v1
      ;;
   new-ca)
      shift
      for a in "$@"; do
         step certificate create root.linkerd.cluster.local "$a-ca.crt" "$a-ca.key" --not-after=8700h --no-password --insecure --profile root-ca --force
         step certificate create identity.linkerd.cluster.local "$a-identity.crt" "$a-identity.key" --not-after=8700h --no-password --insecure --profile intermediate-ca --ca "$a-ca.crt" --ca-key "$a-ca.key" --force
      done
      cat v*-ca.crt > trust-anchors.crt
      exit 0
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
      echo rotate
      exit 0
      ;;
esac
