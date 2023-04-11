{{/*
Common labels
*/}}
{{- define "quant.labels" -}}
helm.sh/chart: {{ include "quant.chart" . }}
{{ include "quant.selectorLabels" . }}
{{- if .Values.appVersion }}
app.kubernetes.io/version: {{ .Values.appVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create an image pull secret
*/}}
{{- define "quant.imagePullSecretValue" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.secrets.registry.registry (printf "%s:%s" .Values.secrets.registry.user .Values.secrets.registry.token | b64enc) | b64enc }}
{{- end }}
