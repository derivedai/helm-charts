{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "hive-metastore.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hive-metastore.fullname" -}}
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
{{- define "hive-metastore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hive-metastore.commonLabels" -}}
helm.sh/chart: {{ include "hive-metastore.chart" . }}
{{ include "hive-metastore.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hive-metastore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hive-metastore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hive-metastore.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hive-metastore.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create a default fully qualified app name for the postgres requirement.
*/}}
{{- define "hiveMetastore.postgresql.fullname" -}}
{{- $postgresContext := dict "Values" .Values.postgresql "Release" .Release "Chart" (dict "Name" "postgresql") -}}
{{ include "postgresql.fullname" $postgresContext }}
{{- end -}}




{{- define "recurseFlattenMap" -}}
{{- $map := first . -}}
{{- $label := last . -}}
{{- range $key, $val := $map -}}
  {{- $sublabel := list $label $key | join "."  -}}
  {{- if kindOf $val | eq "map" -}}
    {{- list $val $sublabel | include "recurseFlattenMap" -}}
  {{- else }}
        <property>
            <name>{{ $sublabel | toString | trimPrefix "." }}</name>
            <value>{{ $val | toString | trimPrefix "." }}</value>
        </property>
  {{ end -}}
{{- end -}}
{{- end -}}

{{- define "metastore.hiveSite" -}}
{{- $supportedVendors := list "postgres" "mysql" -}}
{{- if not (has .Values.metastore.persistence.dbVendor  $supportedVendors ) }}
    {{ fail (printf "ERROR: %s must be in supported vendor list %s" .Values.metastore.persistence.dbVendor $supportedVendors ) }}
{{- end -}}
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
{{- $baseConfig := .Values.metastore.additionalProperties  -}}
{{- if .Values.metastore.persistence.deployPostgres -}}
    {{ $x := include "hiveMetastore.postgresql.fullname" . }}
    {{- $_ := set $baseConfig "javax.jdo.option.ConnectionURL" (printf "jdbc:postgresql://%s:5432/%s" $x .Values.postgresql.postgresqlDatabase) -}}
{{- else }}
    {{- with .Values.metastore.persistence }}
        {{- if eq "postgres" .dbVendor  }}
            {{- $_ := set $baseConfig "javax.jdo.option.ConnectionURL" (printf "jdbc:postgresql://%s:%d/%s" .dbHost (int64 .dbPort) .dbName) -}}
        {{- else if eq "mysql" .dbVendor }}
            {{-  $_ := set $baseConfig "javax.jdo.option.ConnectionURL" (printf "jdbc:mysql://%s:%d/%s" .dbHost (int64 .dbPort) .dbName) -}}
        {{- end }}
    {{- end }}
{{- end }}
{{- with .Values.metastore.persistence }}
    {{- if eq "postgres" .dbVendor  }}
        {{- $_ := set $baseConfig "javax.jdo.option.ConnectionDriverName" "org.postgresql.Driver"  -}}
    {{- else if eq "mysql" .dbVendor }}
        {{- $_ := set $baseConfig "javax.jdo.option.ConnectionDriverName" "com.mysql.jdbc.Driver" -}}
    {{- end }}
{{- end }}
{{- if .Values.metastore.persistence.deployPostgres -}}
     {{- $_ := set $baseConfig "javax.jdo.option.ConnectionUserName" .Values.postgresql.postgresqlUsername -}}
{{- else -}}
     {{-  $_ := set $baseConfig "javax.jdo.option.ConnectionUserName" .Values.metastore.persistence.dbUser -}}
{{- end -}}
{{- if .Values.metastore.persistence.deployPostgres -}}
     {{- $_ :=  set $baseConfig "javax.jdo.option.ConnectionPassword" .Values.postgresql.postgresqlPassword -}}
{{- else -}}
     {{-  $_ :=  set $baseConfig "javax.jdo.option.ConnectionPassword" .Values.metastore.persistence.dbPassword -}}
{{- end -}}
{{- $_ := set $baseConfig "datanucleus.autoCreateSchema" "false" -}}
{{- $_ := set $baseConfig "datanucleus.fixedDatastore" "true" -}}
{{- list $baseConfig "" | include "recurseFlattenMap" -}}
</configuration>
{{- end -}}

{{- define "metastore.snowflakeConnector" -}}
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
{{- $baseConfig := .Values.snowflakeConnector.config  -}}
{{- list $baseConfig "" | include "recurseFlattenMap" -}}
</configuration>
{{- end -}}
