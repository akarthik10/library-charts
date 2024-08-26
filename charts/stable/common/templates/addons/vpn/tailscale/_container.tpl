{{/*
The Tailscale sidecar container to be inserted.
*/}}
{{- define "common.addon.tailscale.container" -}}
name: tailscale
image: "{{ .Values.addons.vpn.tailscale.image.repository }}:{{ .Values.addons.vpn.tailscale.image.tag }}"
imagePullPolicy: {{ .Values.addons.vpn.tailscale.pullPolicy }}
{{- with .Values.addons.vpn.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.addons.vpn.env }}
env:
  - name: TS_KUBE_SECRET
    value: tailscale-{{ include "common.names.fullname" $ }}
  - name: TS_USERSPACE
    value: false
  {{- $hasTSHostname := false }}
  {{- range . }}
  {{- if eq .name "TS_HOSTNAME" }}
  {{- $hasTSHostname = true }}
  {{- end }}
  {{- end }}
  {{- if not $hasTSHostname }}
  - name: TS_HOSTNAME
    value: "{{ include "common.names.fullname" $ }}"
  {{- end }}
  {{- . | toYaml | nindent 2 }}
{{- end }}
{{- with .Values.addons.vpn.envFrom }}
envFrom:
  {{- . | toYaml | nindent 2 }}
{{- end }}
{{- with .Values.addons.vpn.args }}
args:
  {{- . | toYaml | nindent 2 }}
{{- end }}
{{- if or .Values.addons.vpn.configFile .Values.addons.vpn.configFileSecret .Values.addons.vpn.scripts.up .Values.addons.vpn.scripts.down .Values.addons.vpn.additionalVolumeMounts .Values.persistence.shared.enabled }}
volumeMounts:
{{- if .Values.addons.vpn.scripts.up }}
  - name: vpnscript
    mountPath: /config/up.sh
    subPath: up.sh
{{- end }}
{{- if .Values.addons.vpn.scripts.down }}
  - name: vpnscript
    mountPath: /config/down.sh
    subPath: down.sh
{{- end }}
{{- if .Values.persistence.shared.enabled }}
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
{{- end }}
{{- with .Values.addons.vpn.additionalVolumeMounts }}
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- with .Values.addons.vpn.livenessProbe }}
livenessProbe:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- with .Values.addons.vpn.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
