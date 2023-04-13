<script setup lang="ts">
// @see
useSchemaOrg([
  defineOrganization({
    name: "Websimple",
    "@type": "Organization",
  }),
  defineWebSite({ name: "Horcrux" }),
]);
</script>

<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>
