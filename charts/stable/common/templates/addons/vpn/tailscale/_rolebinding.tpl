{{/*
Tailscale Role Binding
*/}}
{{- define "common.addon.tailscale.rolebinding" -}}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: tailscale-rb-{{ include "common.names.fullname" $ }}
subjects:
- kind: ServiceAccount
  name: tailscale-sa-{{ include "common.names.fullname" $ }}
roleRef:
  kind: Role
  name: tailscale-role-{{ include "common.names.fullname" $ }}
  apiGroup: rbac.authorization.k8s.io
{{- end -}}
