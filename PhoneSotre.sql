-- Tạo Database
CREATE DATABASE PhoneStore;
USE PhoneStore;

drop table Users

-- Tạo bảng Role
CREATE TABLE Role (
  role_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

-- Thêm dữ liệu vào bảng Role
INSERT INTO Role (role_id, name, description) VALUES
  (1, 'User', 'Regular user'),
  (2, 'Admin', 'Administrator');

-- Tạo bảng Users
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255),
  role_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES Role(role_id) ON DELETE CASCADE
);

-- Thêm dữ liệu vào bảng Users
INSERT INTO Users (user_id, username, email, password_hash, full_name, role_id, created_at) VALUES
  (1, 'user1', 'user1@example.com', 'password1', 'User One', 1, GETDATE()),
  (2, 'user2', 'user2@example.com', 'password2', 'User Two', 1, GETDATE()),
  (3, 'user3', 'user3@example.com', 'password3', 'User Three', 1, GETDATE()),
  (4, 'admin1', 'admin1@example.com', 'adminpassword', 'Admin One', 2, GETDATE());

-- Tạo bảng Products
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  brand VARCHAR(50) NOT NULL,
  price DECIMAL(15,2) NOT NULL CHECK (price >= 0),
  description TEXT,
  image_url VARCHAR(255),
  stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (product_id, product_name, brand, price, description, image_url, stock_quantity) VALUES
  (1, 'iPhone 12', 'Apple', 20290000, 'Màn hình 6.1 inch, chip A14 Bionic, camera 12MP kép, pin 2815 mAh, RAM 4GB, ROM 64GB.', 'https://product.hstatic.net/200000525189/product/iphone_12_trang_a6fcadf374044dcbb70861ad92e3c168.png', 50),
  (2, 'iPhone 13', 'Apple', 25290000, 'Màn hình 6.1 inch, chip A15 Bionic, camera 12MP kép, pin 3240 mAh, RAM 4GB, ROM 128GB.', 'https://cdn.viettelstore.vn/Images/Product/ProductImage/452166194.jpeg', 45),
  (3, 'iPhone 14', 'Apple', 27890000, 'Màn hình 6.1 inch, chip A15 Bionic, camera 12MP kép, pin 3279 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/iphone14.jpg', 55),
  (4, 'iPhone 14 Pro', 'Apple', 32890000, 'Màn hình 6.1 inch Super Retina XDR, chip A16 Bionic, camera 48MP, pin 3200 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/iphone14pro.jpg', 35),
  (5, 'iPhone 14 Plus', 'Apple', 30290000, 'Màn hình 6.7 inch, chip A15 Bionic, camera 12MP kép, pin 4325 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/iphone14plus.jpg', 30), 
  (6, 'Galaxy S21', 'Samsung', 22790000, 'Màn hình 6.2 inch, chip Exynos 2100, camera 12MP + 64MP + 12MP, pin 4000 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/galaxys21.jpg', 40),
  (7, 'Galaxy Z Fold3', 'Samsung', 45490000, 'Màn hình 7.6 inch, chip Snapdragon 888, camera 12MP + 12MP + 12MP, pin 4400 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/galaxyzfold3.jpg', 20),
  (8, 'Galaxy S22 Ultra', 'Samsung', 30290000, 'Màn hình 6.8 inch, chip Snapdragon 8 Gen 1, camera 108MP + 12MP + 10MP + 10MP, pin 5000 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/galaxys22ultra.jpg', 40),
  (9, 'Galaxy Z Fold4', 'Samsung', 45490000, 'Màn hình 7.6 inch, chip Snapdragon 8+ Gen 1, camera 50MP + 12MP + 10MP, pin 4400 mAh, RAM 12GB, ROM 512GB.', 'https://example.com/galaxyzfold4.jpg', 15),
  (10, 'Find X3 Pro', 'OPPO', 25290000, 'Màn hình 6.7 inch, chip Snapdragon 888, camera 50MP + 50MP + 13MP + 3MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/findx3pro.jpg', 30),
  (11, 'Find X5 Pro', 'OPPO', 32890000, 'Màn hình 6.7 inch, chip Snapdragon 8 Gen 1, camera 50MP + 50MP + 13MP + 3MP, pin 5000 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/findx5pro.jpg', 25),
  (12, 'Find X5', 'OPPO', 8990000, 'Màn hình 6.55 inch, chip Snapdragon 888, camera 50MP + 13MP + 2MP, pin 4800 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/findx5.jpg', 35),
  (13, 'V21 5G', 'Vivo', 4990000, 'Màn hình 6.44 inch, chip MediaTek Dimensity 800U, camera 64MP + 8MP + 2MP, pin 4000 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/v215g.jpg', 60),
  (14, 'V23 5G', 'Vivo', 5990000, 'Màn hình 6.44 inch, chip MediaTek Dimensity 920, camera 64MP + 8MP + 2MP, pin 4200 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/v235g.jpg', 55),
  (15, 'X80 Pro', 'Vivo', 10990000, 'Màn hình 6.78 inch, chip Snapdragon 8 Gen 1, camera 50MP + 50MP + 12MP + 8MP, pin 4700 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/x80pro.jpg', 25),
  (16, 'X80', 'Vivo', 7990000, 'Màn hình 6.78 inch, chip MediaTek Dimensity 9000, camera 50MP + 12MP + 12MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/x80.jpg', 45),
  (17, 'Spark 7P', 'Tecno', 1490000, 'Màn hình 6.8 inch, chip MediaTek Helio G70, camera 16MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/spark7p.jpg', 80),
  (18, 'Spark 8C', 'Tecno', 1990000, 'Màn hình 6.6 inch, chip Unisoc T606, camera 13MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/spark8c.jpg', 90),
  (19, 'Camon 19 Pro', 'Tecno', 2990000, 'Màn hình 6.8 inch, chip MediaTek Helio G96, camera 64MP + 2MP + 0.3MP, pin 5000 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/camon19pro.jpg', 60),
  (20, 'Camon 19', 'Tecno', 2490000, 'Màn hình 6.8 inch, chip MediaTek Helio G85, camera 50MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/camon19.jpg', 70),
  (21, 'Narzo 30A', 'Realme', 1990000, 'Màn hình 6.5 inch, chip MediaTek Helio G85, camera 13MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/narzo30a.jpg', 70),
  (22, 'Narzo 50A', 'Realme', 2490000, 'Màn hình 6.5 inch, chip MediaTek Helio G85, camera 50MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 128GB.', 'https://example.com/narzo50a.jpg', 65),
  (23, 'Narzo 50i', 'Realme', 1490000, 'Màn hình 6.5 inch, chip Unisoc SC9863A, camera 8MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/narzo50i.jpg', 80),
  (24, 'Narzo 50', 'Realme', 1990000, 'Màn hình 6.6 inch, chip MediaTek Dimensity 810, camera 50MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/narzo50.jpg', 60),
  (25, 'Reno8 Pro', 'OPPO', 18990000, 'Màn hình 6.55 inch AMOLED, chip MediaTek Dimensity 8100-MAX, camera 50MP + 8MP + 2MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/reno8pro.jpg', 35),
  (26, 'Reno8', 'OPPO', 13990000, 'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 1300, camera 50MP + 8MP + 2MP, pin 4500 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/reno8.jpg', 45),
  (27, 'Reno7 Pro', 'OPPO', 11990000, 'Màn hình 6.55 inch AMOLED, chip MediaTek Dimensity 1200-MAX, camera 50MP + 8MP + 2MP, pin 4500 mAh, RAM 8GB, ROM 256GB.', 'https://example.com/reno7pro.jpg', 30),
  (28, 'Reno7', 'OPPO', 9990000, 'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 900, camera 64MP + 8MP + 2MP, pin 4500 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/reno7.jpg', 40),
  (29, 'Reno6 Pro', 'OPPO', 13990000, 'Màn hình 6.55 inch AMOLED, chip MediaTek Dimensity 1200, camera 64MP + 8MP + 2MP + 2MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/reno6pro.jpg', 25),
  (30, 'Reno6', 'OPPO', 9990000, 'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 900, camera 64MP + 8MP + 2MP, pin 4300 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/reno6.jpg', 35),
  (31, 'Mi 11 Ultra', 'Xiaomi', 27990000, 'Màn hình 6.81 inch AMOLED, chip Snapdragon 888, camera 50MP + 48MP + 48MP, pin 5000 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/mi11ultra.jpg', 20),
  (32, 'Mi 11', 'Xiaomi', 14990000, 'Màn hình 6.55 inch AMOLED, chip Snapdragon 888, camera 108MP + 13MP + 5MP, pin 4600 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/mi11.jpg', 35),
  (33, 'Mi 10T Pro', 'Xiaomi', 11990000, 'Màn hình 6.67 inch LCD, chip Snapdragon 865, camera 108MP + 13MP + 5MP, pin 5000 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/mi10tpro.jpg', 30),
  (34, 'Mi 10T', 'Xiaomi', 8990000, 'Màn hình 6.67 inch LCD, chip Snapdragon 865, camera 64MP + 13MP + 5MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/mi10t.jpg', 40),
  (35, 'Redmi Note 11 Pro', 'Xiaomi', 7990000, 'Màn hình 6.67 inch AMOLED, chip MediaTek Helio G96, camera 108MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/redminote11pro.jpg', 35),
  (36, 'Redmi Note 11', 'Xiaomi', 4990000, 'Màn hình 6.43 inch AMOLED, chip MediaTek Helio G88, camera 50MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/redminote11.jpg', 50),
  (37, 'Poco X4 Pro 5G', 'Xiaomi', 6990000, 'Màn hình 6.67 inch AMOLED, chip Snapdragon 695, camera 108MP + 8MP + 2MP, pin 5000 mAh, RAM 8GB, ROM 128GB.', 'https://example.com/pocox4pro.jpg', 30),
  (38, 'Poco M4 Pro 5G', 'Xiaomi', 5990000, 'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 810, camera 64MP + 8MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/pocom4pro.jpg', 40),
  (39, 'Poco M3 Pro 5G', 'Xiaomi', 4990000, 'Màn hình 6.5 inch IPS LCD, chip MediaTek Dimensity 700, camera 48MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 128GB.', 'https://example.com/pocom3pro.jpg', 35),
  (40, 'Redmi 10', 'Xiaomi', 3990000, 'Màn hình 6.5 inch IPS LCD, chip MediaTek Helio G88, camera 50MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/redmi10.jpg', 50),
  (41, 'Redmi 9T', 'Xiaomi', 3490000, 'Màn hình 6.53 inch IPS LCD, chip Snapdragon 662, camera 48MP + 8MP + 2MP + 2MP, pin 6000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/redmi9t.jpg', 45),
  (42, 'Redmi 9A', 'Xiaomi', 1990000, 'Màn hình 6.53 inch IPS LCD, chip MediaTek Helio G25, camera 13MP, pin 5000 mAh, RAM 2GB, ROM 32GB.', 'https://example.com/redmi9a.jpg', 60),
  (43, 'Redmi 9C', 'Xiaomi', 2490000, 'Màn hình 6.53 inch IPS LCD, chip MediaTek Helio G35, camera 13MP + 2MP + 2MP, pin 5000 mAh, RAM 3GB, ROM 64GB.', 'https://example.com/redmi9c.jpg', 55),
  (44, 'Redmi Note 11S', 'Xiaomi', 5990000, 'Màn hình 6.43 inch AMOLED, chip MediaTek Helio G96, camera 108MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/redminote11s.jpg', 40),
  (45, 'Redmi Note 10 Pro', 'Xiaomi', 6990000, 'Màn hình 6.67 inch AMOLED, chip Snapdragon 732G, camera 108MP + 8MP + 5MP + 2MP, pin 5020 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/redminote10pro.jpg', 35),
  (46, 'Redmi Note 10', 'Xiaomi', 4990000, 'Màn hình 6.43 inch AMOLED, chip Snapdragon 678, camera 48MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/redminote10.jpg', 45),
  (47, 'Redmi 10 Prime', 'Xiaomi', 5990000, 'Màn hình 6.5 inch IPS LCD, chip MediaTek Helio G88, camera 50MP + 8MP + 2MP + 2MP, pin 6000 mAh, RAM 6GB, ROM 128GB.', 'https://example.com/redmi10prime.jpg', 40),
  (48, 'Redmi 10C', 'Xiaomi', 2990000, 'Màn hình 6.71 inch IPS LCD, chip Snapdragon 680, camera 13MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', 'https://example.com/redmi10c.jpg', 50),
  (49, 'Redmi Note 11 Pro+', 'Xiaomi', 9990000, 'Màn hình 6.67 inch AMOLED, chip MediaTek Helio G96, camera 108MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 8GB, ROM 256GB.', 'https://example.com/redminote11proplus.jpg', 30),
  (50, 'Galaxy Z Fold4', 'Samsung', 49990000, 'Màn hình chính 7.6 inch, màn hình ngoài 6.2 inch, chip Snapdragon 8+ Gen 1, camera 50MP + 12MP + 10MP, pin 4400 mAh, RAM 12GB, ROM 256GB.', 'https://example.com/galaxyzfold4.jpg', 20);

ALTER TABLE Orders
ALTER COLUMN user_id INT NULL;

-- Tạo bảng Orders
CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(15,2) NOT NULL CHECK (total_amount >= 0),
  status VARCHAR(50) DEFAULT 'Pending',
  shipping_address VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


-- Tạo bảng Cart
CREATE TABLE Cart (
  cart_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Tạo bảng Order_Items
CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  price DECIMAL(15,2) NOT NULL CHECK (price >= 0),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Tạo bảng Reviews
CREATE TABLE Reviews (
  review_id INT PRIMARY KEY,
  product_id INT NOT NULL,
  user_id INT NULL,  -- Allowing NULL for the foreign key constraint
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL
);
