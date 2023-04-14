<script setup lang="ts">
// @see
useSchemaOrg([
  defineOrganization({
    name: "Websimple",
    "@type": "Organization",
  }),
  defineWebSite({ name: "DevStack" }),
]);
</script>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
