CREATE TABLE "merchant"
(
  "id"          uuid NOT NULL DEFAULT gen_random_uuid(),
  "name"        text NOT NULL,
  "description" text NOT NULL,
  PRIMARY KEY ("id"),
  UNIQUE ("name")
);

CREATE TABLE "product_category"
(
  "id"                uuid NOT NULL DEFAULT gen_random_uuid(),
  "name"              text NOT NULL,
  "parent_category_id" uuid,
  PRIMARY KEY ("id"),
  UNIQUE ("name"),
  FOREIGN KEY ("parent_category_id") REFERENCES "product_category" ("id") ON UPDATE restrict ON DELETE restrict
);

CREATE TABLE "product_type"
(
  "id"          uuid NOT NULL DEFAULT gen_random_uuid(),
  "category_id" uuid NOT NULL,
  "name"        text NOT NULL,
  "unit"        text NOT NULL,
  "pictureUrl"  text,
  PRIMARY KEY ("id"),
  UNIQUE ("name"),
  FOREIGN KEY ("category_id") REFERENCES "product_category" ("id") ON UPDATE restrict ON DELETE restrict
);

CREATE TABLE "product"
(
  "id"          uuid           NOT NULL DEFAULT gen_random_uuid(),
  "merchant_id" uuid           NOT NULL,
  "type_id"     uuid           NOT NULL,
  "description" text,
  "picture_url"  text           NOT NULL,
  "price"       numeric(10, 2) NOT NULL,
  "available"   boolean        NOT NULL,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("merchant_id") REFERENCES "merchant" ("id") ON UPDATE restrict ON DELETE restrict,
  FOREIGN KEY ("type_id") REFERENCES "product_type" ("id") ON UPDATE restrict ON DELETE restrict
);
