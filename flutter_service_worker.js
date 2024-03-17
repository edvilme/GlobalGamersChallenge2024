'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "d6118d0b84138f0cb9866dcff0f626e3",
"/": "d6118d0b84138f0cb9866dcff0f626e3",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "e3154204dd9fabadd02e21652676fd28",
"assets/AssetManifest.bin.json": "130641af792f6a3dc56774cfd04543f1",
"assets/assets/images/trashcan_organic.png": "7c3624f0991a70c536092f755eac2613",
"assets/assets/images/organic/trash_bones.png": "441bad9d0728a87a5030bf867a5b4c53",
"assets/assets/images/organic/trash_hamburger.png": "a76a643731096eebe2ac53b4355400ed",
"assets/assets/images/organic/trash_fish.png": "f991ea107de0d086fee817beeaf616ea",
"assets/assets/images/organic/trash_apple.png": "9b5c4b79a07e78c642060d25cfcd76bd",
"assets/assets/images/organic/trash_flower.png": "1e3f086d23a4cd15682bc0fa186dfc8b",
"assets/assets/images/trashcan_plastic.png": "8fb8a5b36d4e0a3d105d5ae9005427da",
"assets/assets/images/plastic/trash_bottle_3.png": "7984566b0ae4be4bc4e79119d8f754ca",
"assets/assets/images/plastic/trash_plastic_bag.png": "34333ec16500eb7d6e5e8121959c0558",
"assets/assets/images/plastic/trash_bottle.png": "27f6aa49b6171f5a8f5895fcb6f6d2f5",
"assets/assets/images/plastic/trash_bottle_2.png": "f6c227c1ce4b655ae94d8c67ff35dfaf",
"assets/assets/images/plastic/trash_plastic_box.png": "7a9c382a78046349165b5a1be0dc6e79",
"assets/assets/images/magic/trash_die.png": "42bc8ca0c9a5785486ac8451ea7e2997",
"assets/assets/images/paper/trash_newspaper.png": "fe85cb04e6b1f5af7cbb790c82ea7a26",
"assets/assets/images/paper/trash_paper.png": "fd9353b3fd4b7132e956de513fb8e1a9",
"assets/assets/images/paper/trash_box.png": "5259e3467ec0e78de72019056549ebdb",
"assets/assets/images/paper/trash_paper_juice_box.png": "fab61e38c8a87bf55da796b239d8a3e3",
"assets/assets/images/paper/trash_paper_bag.png": "7a98dd08c855d1518df086099eb379b3",
"assets/assets/images/pause.circle.fill.png": "509d57836b325cb465911ae09fed8791",
"assets/assets/images/glass/trash_bulb.png": "fa7ba2d28c5ac02c96cb7a08960574a9",
"assets/assets/images/glass/trash_water_glass.png": "057844cc91d39df152e4520f68cba176",
"assets/assets/images/glass/trash_glass_bottle.png": "41d7d88c0c27d38159372cc60180887f",
"assets/assets/images/glass/trash_cup.png": "61380b128676bec015f070452ec85d08",
"assets/assets/images/glass/trash_glass_pieces.png": "91b1956f36ee7dad161f05ac0beffe6e",
"assets/assets/images/trashcan_paper.png": "f5f062ba006429e64305ec6aa8548f86",
"assets/assets/images/trash_mountain.png": "66d18084361388204dba1c9436a79160",
"assets/assets/images/trashcan_glass.png": "30bce7c1bf2dd324847b89b80cf490b5",
"assets/assets/images/app_icon.png": "12e9d2a230e054261fbdcad0c544e297",
"assets/AssetManifest.bin": "582187820231a5957d15558b2e3b2245",
"assets/NOTICES": "aa6ac78c6cbfff9f667893b75001e341",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/add_to_google_wallet/assets/svg/buttons/et_add_to_google_wallet_wallet-button.svg": "c0b6fbcba5ea9e222d49da62d55c1f07",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ar_add_to_google_wallet_wallet-button.svg": "8ed2b5dc8ea42390bc1f22f9814954b0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enSG_add_to_google_wallet_wallet-button.svg": "568708442552f3b3caaf6161f4868d72",
"assets/packages/add_to_google_wallet/assets/svg/buttons/uk_add_to_google_wallet_wallet-button.svg": "6835dbf7541d926e3d9367fd67c703d4",
"assets/packages/add_to_google_wallet/assets/svg/buttons/es419_add_to_google_wallet_wallet-button.svg": "cb9db60b0742150ae3ab547e4f4ef0e6",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ca_add_to_google_wallet_wallet-button.svg": "0a4925620a47363661cb7a51b4ab5a58",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ka_add_to_google_wallet_wallet-button.svg": "be97561ee61811a8ac3dc8128b5301e8",
"assets/packages/add_to_google_wallet/assets/svg/buttons/bg_add_to_google_wallet_wallet-button.svg": "fb36a9dd4688eabe5e9e50b029564227",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hu_add_to_google_wallet_wallet-button.svg": "e534db0e513768092bc4c2b6b4e3beea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/fp_add_to_google_wallet_wallet-button.svg": "23b16942ca07f225da0d4ff044825213",
"assets/packages/add_to_google_wallet/assets/svg/buttons/no_add_to_google_wallet_wallet-button.svg": "87eac0605cbb7056f2e32e270da14d07",
"assets/packages/add_to_google_wallet/assets/svg/buttons/jp_add_to_google_wallet_wallet-button.svg": "d139a2176756c1b0ccf9c033450d4473",
"assets/packages/add_to_google_wallet/assets/svg/buttons/br_add_to_google_wallet_wallet-button.svg": "d711b404a7d3b86f3cc5c8acedc50dbd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/cz_add_to_google_wallet_wallet-button.svg": "f3f2178af2bc4cdf103826cd98c9369b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sq_add_to_google_wallet_wallet-button.svg": "e568f2f0545c2993b412f7f5b42320ec",
"assets/packages/add_to_google_wallet/assets/svg/buttons/uz_add_to_google_wallet_wallet-button.svg": "9426afa0cd9540106ef93fd46a1fd217",
"assets/packages/add_to_google_wallet/assets/svg/buttons/az_add_to_google_wallet_wallet-button.svg": "1c545af772b2f9b1e50b23b63c9f98da",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enCA_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/esES_add_to_google_wallet_wallet-button.svg": "5946c137c2cb5015d3bb2d2b89bbfa2f",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hy_add_to_google_wallet_wallet-button.svg": "86474c2f3e14d467e45a8b9c2b81402b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/bs_add_to_google_wallet_wallet-button.svg": "6aa017fb69dfc3cf76058285e1d630d8",
"assets/packages/add_to_google_wallet/assets/svg/buttons/my_add_to_google_wallet_wallet-button.svg": "04157e592054aabc39fd2215792baaea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/pl_add_to_google_wallet_wallet-button.svg": "72e75b2a37a77648f882878b4512952b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enIN_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/by_add_to_google_wallet_wallet-button.svg": "fc717a3f3da30fe862a310d643fe92ad",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sk_add_to_google_wallet_wallet-button.svg": "b16f6ed9494595a14ade427d4db1b0b1",
"assets/packages/add_to_google_wallet/assets/svg/buttons/vi_add_to_google_wallet_wallet-button.svg": "35162663f63d206ae1e2cc30be7cfffc",
"assets/packages/add_to_google_wallet/assets/svg/buttons/lt_add_to_google_wallet_wallet-button.svg": "cb8ba3e609a1b57f225f05eaddcb8e19",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ky_add_to_google_wallet_wallet-button.svg": "157b7963b74a17c4bfd5de0db482b399",
"assets/packages/add_to_google_wallet/assets/svg/buttons/lv_add_to_google_wallet_wallet-button.svg": "943d879ec5f1533769d3bc60e849d213",
"assets/packages/add_to_google_wallet/assets/svg/buttons/dk_add_to_google_wallet_wallet-button.svg": "60d5092f469e20135016aaf3cc5d213b",
"assets/packages/add_to_google_wallet/assets/svg/buttons/tr_add_to_google_wallet_wallet-button.svg": "f1b61f991a8ab72fe7833d054aab7e97",
"assets/packages/add_to_google_wallet/assets/svg/buttons/he_add_to_google_wallet_wallet-button.svg": "a9a052a290a19f712a6685bbcd190ca0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enUS_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/de_add_to_google_wallet_wallet-button.svg": "bfb158c4b084482543e8ef901df02d21",
"assets/packages/add_to_google_wallet/assets/svg/buttons/id_add_to_google_wallet_wallet-button.svg": "7139c1614230fce1ea41c7f9cadda52f",
"assets/packages/add_to_google_wallet/assets/svg/buttons/gr_add_to_google_wallet_wallet-button.svg": "64c855f01d129b8d71ceeea8ed2a3d71",
"assets/packages/add_to_google_wallet/assets/svg/buttons/frCA_add_to_google_wallet_wallet-button.svg": "bc2f47f5f3b8f8f3253770fc89a540c7",
"assets/packages/add_to_google_wallet/assets/svg/buttons/hr_add_to_google_wallet_wallet-button.svg": "b6d10a9fbd63b345fc2825b1e4a3abf0",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enAU_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/is_add_to_google_wallet_wallet-button.svg": "cb03001a5ab3d58ebbfa3d6472aa4a23",
"assets/packages/add_to_google_wallet/assets/svg/buttons/zhHK_add_to_google_wallet_wallet-button.svg": "147b0913cc5f029978e33006dcbdee13",
"assets/packages/add_to_google_wallet/assets/svg/buttons/zhTW_add_to_google_wallet_wallet-button.svg": "147b0913cc5f029978e33006dcbdee13",
"assets/packages/add_to_google_wallet/assets/svg/buttons/fl_add_to_google_wallet_wallet-button.svg": "d5141c1d2fa7c71f6d3f8024e60980a4",
"assets/packages/add_to_google_wallet/assets/svg/buttons/th_add_to_google_wallet_wallet-button.svg": "ab9c343ba68db03201e572a234cb5412",
"assets/packages/add_to_google_wallet/assets/svg/buttons/it_add_to_google_wallet_wallet-button.svg": "fbdc320908b10990db14acc6f433ac7c",
"assets/packages/add_to_google_wallet/assets/svg/buttons/frFR_add_to_google_wallet_wallet-button.svg": "bc2f47f5f3b8f8f3253770fc89a540c7",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enGB_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/se_add_to_google_wallet_wallet-button.svg": "4f87e7ee56c9aeddf475f1a4c6abd375",
"assets/packages/add_to_google_wallet/assets/svg/buttons/enZA_add_to_google_wallet_wallet-button.svg": "c283cb0dc517d3bc6de2590b3bac2fcf",
"assets/packages/add_to_google_wallet/assets/svg/buttons/mk_add_to_google_wallet_wallet-button.svg": "ec59cda1b4b0569349d5b04b5fecb177",
"assets/packages/add_to_google_wallet/assets/svg/buttons/pt_add_to_google_wallet_wallet-button.svg": "d711b404a7d3b86f3cc5c8acedc50dbd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sr_add_to_google_wallet_wallet-button.svg": "fda80812ddb5b99cf767ed19a6ceefea",
"assets/packages/add_to_google_wallet/assets/svg/buttons/kk_add_to_google_wallet_wallet-button.svg": "cecbc3f3d7973d388b088294b1ea265a",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ru_add_to_google_wallet_wallet-button.svg": "fc717a3f3da30fe862a310d643fe92ad",
"assets/packages/add_to_google_wallet/assets/svg/buttons/esUS_add_to_google_wallet_wallet-button.svg": "cb9db60b0742150ae3ab547e4f4ef0e6",
"assets/packages/add_to_google_wallet/assets/svg/buttons/sl_add_to_google_wallet_wallet-button.svg": "f89a88aa0b6dfb367c74c621bda15ffd",
"assets/packages/add_to_google_wallet/assets/svg/buttons/nl_add_to_google_wallet_wallet-button.svg": "efaee620d9c06b1fd5181f2b2395a3d1",
"assets/packages/add_to_google_wallet/assets/svg/buttons/ro_add_to_google_wallet_wallet-button.svg": "406323ed5b974f0f67fa516f7653bde0",
"assets/AssetManifest.json": "f8160dc10debe8f53b184537c2f46055",
"version.json": "85baa4ed3d299231b9c471d08914e934",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "160666899fb23208295c0dc3c2fbf3e2",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"main.dart.js": "94980c66a047ca547a167bf7d41b36b4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
