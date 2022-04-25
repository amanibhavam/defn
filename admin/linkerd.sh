#!/usr/bin/env bash

context="k3d-$(basename "$(pwd)")"

case "${1}" in
   install)
      linkerd install --context "${context}" --identity-trust-anchors-file "../$2-ca.crt" --identity-issuer-certificate-file "../$2-identity.crt" --identity-issuer-key-file "../$2-identity.key" | kubectl --context "${context}" apply -f -
      sleep 10; linkerd check --context "${context}" --proxy

      linkerd viz install --context "${context}" | kubectl apply --context "${context}" -f -
      sleep 10; linkerd viz check --context "${context}"
      linkerd check --context "${context}" --proxy

      linkerd multicluster install --context "${context}" | kubectl --context "${context}" apply -f -
      sleep 10; linkerd multicluster check --context "${context}"
      ;;
   add-anchor)
      linkerd upgrade --context "${context}" --identity-trust-anchors-file "../trust-anchors.crt" --identity-issuer-certificate-file "../$2-identity.crt" --identity-issuer-key-file "../$2-identity.key" | kubectl apply --context "${context}" -f -
      ;;
   restart)
      kubectl --context "${context}" -n linkerd rollout restart deployments
      sleep 10; linkerd check --context "${context}" --proxy
      ;;
   change-identity)
      linkerd upgrade --context "${context}" --identity-trust-anchors-file "../trust-anchors.crt" --identity-issuer-certificate-file "../$2-identity.crt" --identity-issuer-key-file "../$2-identity.key" | kubectl apply --context "${context}" -f -
      ;;
   only-anchor)
      linkerd upgrade --identity-trust-anchors-file "../$2-ca.crt" --identity-issuer-certificate-file "../$2-identity.crt" --identity-issuer-key-file "../$2-identity.key" | kubectl apply -f -
      ;;
   recreate)
      linkerd viz uninstall --context "${context}"
      linkerd uninstall --context "${context}"
      "$0" install v1
      ;;
   new-ca)
      shift
      for a in "$@"; do
         step certificate create root.linkerd.cluster.local "../$a-ca.crt" "../$a-ca.key" --not-after=8700h --no-password --insecure --profile root-ca --force
         step certificate create identity.linkerd.cluster.local "../$a-identity.crt" "../$a-identity.key" --not-after=8700h --no-password --insecure --profile intermediate-ca --ca "../$a-ca.crt" --ca-key "../$a-ca.key" --force
      done
      cat ../v*-ca.crt > ../trust-anchors.crt
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
   link)
      shift
      source="$1"; shift
      for a in "$@"; do
         linkerd --context="k3d-$a" multicluster link --cluster-name "$a" | kubectl --context="k3d-${source}" apply -f -
      done
      ;;
   *)
      echo recreate
      echo rotate
      exit 0
      ;;
esac
