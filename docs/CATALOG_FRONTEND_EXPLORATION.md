# Catalog Frontend – Exploration Report

Comparison of your Flutter catalog implementation against the **Catalog Service – Frontend Implementation Guide**.

**Base:** `/api/v1/tenants/:id/catalog` · **Auth:** `Authorization: Bearer <token>`

---

## 1. Summary

| Area | Status | Notes |
|------|--------|-------|
| **API path helpers** | ✅ | All endpoints in `api_endpoints.dart`; `baseUrl` + path = `/api/v1/tenants/:id/catalog/...` |
| **Categories** | ✅ | List, Create, Edit, Delete; form: name, code, icon, color, sort_order, is_active |
| **Resources** | ✅ | List (resource_type, is_active), Create, Edit, Delete; assign from Offering Detail |
| **Offerings** | ✅ | List (category_id, is_active), Create, Edit, Delete, **Detail (hub)** |
| **Variants** | ✅ | List, Add, Edit, Delete from Detail; `POST /variants` with offering_id, name, metadata |
| **Pricing rules** | ✅ | List, Add, Edit, Delete from Detail; variant_id, resource_id, price, currency, rule_type |
| **Availability rules** | ⚠️ **Read-only** | Shown in Detail when present; **no Add/Edit/Delete** (see §2.7) |
| **Catalog Home / Tabs** | ⚠️ Optional | Guide suggests [Categories][Offerings][Resources] tabs; you use separate routes from dashboard |

---

## 2. Entity-by-Entity

### 2.1 Categories ✅

| Guide | Your implementation |
|-------|---------------------|
| GET/POST/PUT/DELETE `/categories`, `/:id` | `CategoryApiService`: list, get, create, update, delete |
| List: page, page_size, is_active (optional) | `listCategories(page, pageSize, isActive)` |
| Create: name, code; icon, color, is_active | `CreateCategoryRequest` + `CategoryFormDialog` (name, code, icon, color, sort_order, is_active) |
| `CategoriesPage` + `CategoryFormDialog` | ✅ |

**Routes:** `/catalog/categories` → `CategoriesPage`.

---

### 2.2 Resources ✅

| Guide | Your implementation |
|-------|---------------------|
| GET/POST/PUT/DELETE `/resources`, `/:id` | `ResourceApiService`: list, get, create, update, delete |
| List: page, page_size, resource_type, is_active | `listResources(page, pageSize, resourceType, isActive)` |
| Create: resource_type (PERSON\|VEHICLE\|ROOM), name; metadata, is_active | `CreateResourceRequest` + `ResourceFormDialog` |
| `ResourcesPage` with Type ▼ filter | `_buildFilters`: `resource_type` dropdown + Active/Inactive chips |

**Assign/Unassign:** From Offering Detail → `_AssignResourcesDialog` (GET /resources, POST /offerings/:id/resources, DELETE /offerings/:id/resources/:rid). ✅

**Routes:** `/catalog/resources` → `ResourcesPage`.

---

### 2.3 Offerings ✅

| Guide | Your implementation |
|-------|---------------------|
| GET/POST/PUT/DELETE `/offerings`, `/:id`, `/:id/detail` | `OfferingApiService`: list, get, getDetail, create, update, delete |
| List: page, page_size, category_id, is_active | `listOfferings(..., categoryId, isActive)` |
| Create: category_id, name, booking_type; description, duration_minutes, capacity, requires_resource, metadata, is_active | `CreateOfferingRequest` has all; `OfferingFormDialog` has all except `metadata` (optional) |
| Detail = hub for Resources, Variants, Pricing, Availability | `getOfferingDetail` → `_OfferingDetailContent` with 4 sections |

**Routes:** `/catalog/offerings` → `OfferingsPage`. Detail = bottom sheet `_showDetailSheet` → `_OfferingDetailContent`.

---

### 2.4 Variants (from Offering Detail) ✅

| Guide | Your implementation |
|-------|---------------------|
| GET `/offerings/:oid/variants` | Via `detail.variants` (or could use `offeringVariants`) |
| POST `/variants` body: offering_id, name; metadata | `VariantApiService.createVariant` + `VariantFormDialog` (offering_id, name, metadata JSON) |
| PUT `/variants/:id`, DELETE `/variants/:id` | `updateVariant`, `deleteVariant` in `OfferingViewModel` |

**UI:** Detail section “Variants” with [+ Add variant], per-row [Edit] [Delete]. ✅

---

### 2.5 Pricing rules (from Offering Detail) ✅

| Guide | Your implementation |
|-------|---------------------|
| GET `/offerings/:oid/pricing-rules` | Via `detail.pricing_rules` |
| POST `/pricing-rules` body: offering_id, price, currency, rule_type; variant_id, resource_id | `PricingRuleApiService` + `PricingRuleFormDialog` (offering_id, price, currency, rule_type FLAT|TIME_BASED|CAPACITY; variant_id, resource_id from detail.variants & resourcesForAssign) |
| PUT/DELETE `/pricing-rules/:id` | `updatePricingRule`, `deletePricingRule` in `OfferingViewModel` |

**UI:** Detail section “Pricing” with [+ Add pricing rule], per-row [Edit] [Delete]. ✅

---

### 2.6 Assign resources (from Offering Detail) ✅

| Guide | Your implementation |
|-------|---------------------|
| List: `detail.resources` | `OfferingDetailResponse.resources` |
| Assign: POST `/offerings/:id/resources` `{"resource_ids":["uuid",...]}` | `assignResourcesToOffering(offeringId, resourceIds)` |
| Unassign: DELETE `/offerings/:id/resources/:rid` | `unassignResourceFromOffering(offeringId, resourceId)` |

**UI:** “Assign resources” → `_AssignResourcesDialog` (checkboxes from `GET /resources`). Per-row [Unassign]. ✅  

If `detail.resources` is empty, you fallback to `getOfferingResources` (GET /offerings/:id/resources). ✅

---

### 2.7 Availability rules ⚠️ **Gap – Read-only**

| Guide | Your implementation |
|-------|---------------------|
| GET `/offerings/:oid/availability-rules` | Via `detail.availability_rules` only ✅ |
| POST `/availability-rules` body: offering_id, day_of_week (0–6); start_time, end_time, max_bookings, slot_size_minutes | ❌ **Not implemented** |
| PUT/DELETE `/availability-rules/:id` | ❌ **Not implemented** |
| **Rule:** One per (offering_id, day_of_week). When adding, only show days without a rule. | N/A |

**What exists:**

- **Model:** `OfferingAvailabilityRule` in `offering_model.dart` (id, offering_id, day_of_week, start_time, end_time, max_bookings, slot_size_minutes). ✅  
- **Endpoints in `api_endpoints.dart`:**  
  `availabilityRules(tenantId)`, `availabilityRule(tenantId, id)`, `offeringAvailabilityRules(tenantId, offeringId)`. ✅  
- **Detail UI** (`offerings_page.dart` ~686): only **displays** when `d.availabilityRules.isNotEmpty`:
  - `Text('Availability (${d.availabilityRules.length})')`
  - `...d.availabilityRules.map((a) => Text('Day ${a.dayOfWeek} ${a.startTime ?? ""}–${a.endTime ?? ""} Slot:${a.slotSizeMinutes ?? ""}min Max:${a.maxBookings ?? ""}'))`

**What’s missing:**

1. **`AvailabilityRuleApiService`**  
   - `listByOffering(tenantId, offeringId)` or rely on detail  
   - `create(tenantId, {offering_id, day_of_week, start_time, end_time, max_bookings?, slot_size_minutes?})`  
   - `get(tenantId, id)`, `update(tenantId, id, ...)`, `delete(tenantId, id)`

2. **`AvailabilityRuleFormDialog`**  
   - Create: offering_id prefilled, day_of_week (0=Sun…6=Sat) — **only days not yet in `detail.availability_rules`**  
   - start_time, end_time (HH:MM), max_bookings, slot_size_minutes  
   - Edit: same fields for existing rule.

3. **`OfferingViewModel`**  
   - `createAvailabilityRule(...)`, `updateAvailabilityRule(...)`, `deleteAvailabilityRule(...)`  
   - (Optional) `loadAvailabilityRules(offeringId)` if you want to refetch without full detail.)

4. **Detail UI (Availability section)**  
   - Always show the “Availability” block (even when empty).  
   - [+ Add] → `AvailabilityRuleFormDialog` (create).  
   - Per-row [Edit] [Delete] calling VM then `_loadDetail()`.

5. **`CatalogModule`**  
   - No new provider needed if you keep logic in `OfferingViewModel` and inject `AvailabilityRuleApiService` into it (similar to `PricingRuleApiService`).

---

## 3. Implementation Order (Guide vs Yours)

Guide order: **Categories, Resources → Offerings → (from Detail) Variants, Pricing, Availability, Resource assignment.**

Your structure matches: Categories and Resources are independent; Offerings depend on categories; Variants, Pricing, Availability, and Resource assignment are all from Offering Detail. ✅  

The only out-of-order part is **Availability**, which is present in the detail response and UI as read-only, but has no CRUD.

---

## 4. UI → API Mapping

| Screen | Guide | Yours |
|--------|-------|-------|
| Catalog Home / Tabs | [Categories][Offerings][Resources] | Separate `/catalog/categories`, `/catalog/offerings`, `/catalog/resources` from dashboard |
| Categories list | GET /categories, POST, GET/PUT/DELETE /:id | ✅ |
| Offerings list | GET /offerings?category_id=, filters | ✅ (category + is_active) |
| Offering Detail (hub) | GET /offerings/:id/detail | ✅ |
| Resources (in Detail) | Assign: POST …/resources; Unassign: DELETE …/resources/:rid | ✅ |
| Variants (in Detail) | GET …/variants, POST /variants, PUT/DELETE /variants/:id | ✅ |
| Pricing (in Detail) | GET …/pricing-rules, POST /pricing-rules, PUT/DELETE /pricing-rules/:id | ✅ |
| **Availability (in Detail)** | GET …/availability-rules, POST /availability-rules, PUT/DELETE /availability-rules/:id | **Display only**; no POST/PUT/DELETE |
| Resources list | GET /resources, Type ▼, POST, GET/PUT/DELETE /:id | ✅ |

---

## 5. Data Flow and State

- **Categories:** Fetched for Offering form and filters; you invalidate/refresh on create/update/delete. ✅  
- **Resources:** List for Resources page and for “Assign” in Detail; you load `resourcesForAssign` when opening Assign or Pricing. ✅  
- **Offerings:** List with category_id and is_active; refresh after CRUD. ✅  
- **Detail:** After Variants, Pricing, Resources (assign/unassign) you refetch `getOfferingDetail` (and if needed `getOfferingResources`). ✅  
- **Availability:** Would follow the same pattern: after create/update/delete → `_loadDetail()` (and/or a dedicated list). Right now only the initial detail is used.

---

## 6. API Quick Reference (Your `api_endpoints.dart`)

Aligned with the guide:

- `catalogBase(tenantId)` → `/tenants/$tenantId/catalog` (prefixed by `baseUrl` = `…/api/v1`).
- Categories, Offerings, Resources, `offeringResources`, `offeringResource`.
- `variants`, `variant`, `offeringVariants`.
- `pricingRules`, `pricingRule`, `offeringPricingRules`.
- `availabilityRules`, `availabilityRule`, `offeringAvailabilityRules`. (Only availability **calls** are missing in a dedicated service.)

---

## 7. Recommendations

### 7.1 Complete Availability Rules (to match guide)

1. **`lib/features/catalog/services/availability_rule_api_service.dart`**  
   - Implement: list by offering (or use detail), create (POST /availability-rules), get, update, delete using `ApiEndpoints.availabilityRules`, `availabilityRule`, `offeringAvailabilityRules`.

2. **`lib/features/catalog/views/availability_rule_form_dialog.dart`**  
   - Create: offering_id (prefilled), day_of_week (dropdown 0–6, **excluding days already in `detail.availability_rules`**), start_time, end_time (HH:MM), max_bookings, slot_size_minutes.  
   - Edit: same fields for the selected rule.

3. **`OfferingViewModel`**  
   - Inject `AvailabilityRuleApiService`.  
   - Add: `createAvailabilityRule`, `updateAvailabilityRule`, `deleteAvailabilityRule`.

4. **`offering_model.dart`**  
   - `OfferingAvailabilityRule` is already suitable for create/update request bodies (you may add a `CreateAvailabilityRuleRequest` / `UpdateAvailabilityRuleRequest` if you want to mirror other entities, or build a `Map` in the service).

5. **`offerings_page.dart` – `_OfferingDetailContent`**  
   - Availability section:  
     - Always visible (remove `if (d.availabilityRules.isNotEmpty)` for the section header and the “[+ Add]” area).  
     - “[+ Add]” → open `AvailabilityRuleFormDialog` (create) → onSuccess `_loadDetail()`.  
     - Per-row [Edit] [Delete] for each `OfferingAvailabilityRule`.

6. **`CatalogModule`**  
   - Instantiate `AvailabilityRuleApiService` and pass it into `OfferingViewModel` (same pattern as `PricingRuleApiService`).

### 7.2 Optional

- **Catalog Home with tabs:** One route (e.g. `/catalog`) with a tabbed UI [Categories | Offerings | Resources], each tab showing the current list page.  
- **Offering form – metadata:** Add an optional JSON or key-value field for `metadata` in `OfferingFormDialog` if you need it.  
- **Error handling:** Already consistent with guide (e.g. 400 `validation_error`, 404 `not_found`); you can centralize messages if desired.

---

## 8. Files Touched for a Full Catalog (Including Availability CRUD)

| Action | File |
|--------|------|
| **Create** | `lib/features/catalog/services/availability_rule_api_service.dart` |
| **Create** | `lib/features/catalog/views/availability_rule_form_dialog.dart` |
| **Edit** | `lib/features/catalog/viewmodels/offering_vm.dart` (inject service, add create/update/delete) |
| **Edit** | `lib/features/catalog/views/offerings_page.dart` (Availability: always show, Add/Edit/Delete) |
| **Edit** | `lib/features/catalog/catalog_module.dart` (create `AvailabilityRuleApiService`, pass to `OfferingViewModel`) |
| **Optional** | `lib/features/catalog/models/offering_model.dart` – add `CreateAvailabilityRuleRequest` / `UpdateAvailabilityRuleRequest` if you standardize request DTOs |

---

**Conclusion:** Your catalog implements the guide for **Categories, Resources, Offerings, Variants, Pricing, and Resource assignment**. The only missing piece is **Availability rules CRUD** (service, form, VM methods, and Detail UI for Add/Edit/Delete). Endpoints and models for availability are already in place.
