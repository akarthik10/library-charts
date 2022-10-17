{{/*
Tailscale SA
*/}}
{{- define "common.addon.tailscale.serviceaccount" -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tailscale-{{ include "common.names.fullname" $ }}
{{- end -}}
