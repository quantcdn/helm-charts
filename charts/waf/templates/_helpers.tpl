{{/*
Expand the name of the chart.
*/}}
{{- define "quant-waf.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "quant-waf.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "quant-waf.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "quant-waf.labels" -}}
helm.sh/chart: {{ include "quant-waf.chart" . }}
{{ include "quant-waf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "quant-waf.selectorLabels" -}}
app.kubernetes.io/name: {{ include "quant-waf.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{ define "quant-waf.config" }}
{
  "notify_slack": "{{ .Values.quant.config.notifySlack | default "" }}",
  "allow_ip": {{ .Values.quant.config.allowIp | toJson }},
  "block_ip": {{ .Values.quant.config.blockIp | toJson }},
  "block_ua": {{ .Values.quant.config.blockUa | toJson }},
  "allow_rules": {{ .Values.quant.config.allowRules | toJson }},
  "block_country": {{ .Values.quant.config.blockCountry | toJson }},
  "paranoia_level": {{ .Values.quant.config.paranoia | default 1 | int }},
  "mode": "{{ .Values.quant.config.mode | default "block" }}",
  "log_level": "{{ .Values.quant.config.logLevel | default "standard" }}",
  "rules": {{ .Values.quant.config.rules | toJson }},
  "httpbl": {
    "httpbl_enabled": {{ .Values.quant.config.httblEnabled | default false }},
    "httpbl_key": "{{ .Values.quant.config.httpblKey | default "" }}",
    "block_suspicious": {{ .Values.quant.config.httpblBlockSuspicious | default false }},
    "block_harvester": {{ .Values.quant.config.httpblBlockHarvester | default true }},
    "block_spam": {{ .Values.quant.config.httpblBlockSpam | default true }},
    "block_search_engine": {{ .Values.quant.config.httpblBlockSearchEngine | default false }}
  }
}
{{ end }}

{{ define "quant-waf.quantConfig" }}
{
  "quant_waf": {
    "endpoint": "{{ .Values.quant.endpoint | default "" }}",
    "key": "{{ .Values.quant.key | default "" }}",
    "organization": "{{ .Values.quant.organization | default "" }}",
    "project": "{{ .Values.quant.project | default "" }}"
  }
}
{{ end }}

{{ define "quant-waf.errorPage" }}
{{ .Values.quant.errorPage | replace ":+" "{{" | replace "+:" "}}" }}
{{ end }}
