{{/*
Template to render Tailscale addon. It will add the container to the list of additionalContainers.
*/}}
*/}}
{{- define "common.addon.tailscale" -}}
  {{/* Append the Tailscale container to the additionalContainers */}}
  {{- $container := fromYaml (include "common.addon.tailscale.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-tailscale" $container -}}
  {{- end -}}
{{- end -}}
