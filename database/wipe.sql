-- ========================================================
-- WIPE TOTAL - BRASILÂNDIA (INVOKEV8)
-- Este script zera completamente todos os dados das tabelas,
-- resetando os AUTO_INCREMENT para 1 (novo ID 1).
-- ========================================================

USE `invokev8`;

SET FOREIGN_KEY_CHECKS = 0;

-- Contas, Personagens e Permissões
TRUNCATE TABLE `accounts`;
TRUNCATE TABLE `banneds`;
TRUNCATE TABLE `characters`;
TRUNCATE TABLE `dependents`;
TRUNCATE TABLE `fidentity`;
TRUNCATE TABLE `playerdata`;
TRUNCATE TABLE `entitydata`;

-- Veículos e Propriedades
TRUNCATE TABLE `vehicles`;
TRUNCATE TABLE `propertys`;
TRUNCATE TABLE `chests`;
TRUNCATE TABLE `warehouse`;

-- Economia e Finanças
TRUNCATE TABLE `invoices`;
TRUNCATE TABLE `investments`;
TRUNCATE TABLE `taxs`;
TRUNCATE TABLE `transactions`;
TRUNCATE TABLE `razebank_transactions`;

-- Facções, Famílias e Organizações
TRUNCATE TABLE `organizations`;
TRUNCATE TABLE `org_transactions`;
TRUNCATE TABLE `dominations`;
TRUNCATE TABLE `dominations_disputes`;
TRUNCATE TABLE `us_families_logs`;

-- Prisão, Drogas e Atividades
TRUNCATE TABLE `prison`;
TRUNCATE TABLE `planting`;
TRUNCATE TABLE `races`;

-- Loja / Hydrus
TRUNCATE TABLE `hydrus_credits`;
TRUNCATE TABLE `hydrus_scheduler`;

-- Tablet Policial / MDT
TRUNCATE TABLE `felipeex_tablet_fixa`;
TRUNCATE TABLE `felipeex_tablet_img`;

-- Smartphone / Celular
TRUNCATE TABLE `smartphone_bank_invoices`;
TRUNCATE TABLE `smartphone_blocks`;
TRUNCATE TABLE `smartphone_calls`;
TRUNCATE TABLE `smartphone_casino`;
TRUNCATE TABLE `smartphone_contacts`;
TRUNCATE TABLE `smartphone_gallery`;
TRUNCATE TABLE `smartphone_ifood_orders`;
TRUNCATE TABLE `smartphone_instagram`;
TRUNCATE TABLE `smartphone_instagram_followers`;
TRUNCATE TABLE `smartphone_instagram_likes`;
TRUNCATE TABLE `smartphone_instagram_notifications`;
TRUNCATE TABLE `smartphone_instagram_posts`;
TRUNCATE TABLE `smartphone_olx`;
TRUNCATE TABLE `smartphone_paypal_transactions`;
TRUNCATE TABLE `smartphone_tinder`;
TRUNCATE TABLE `smartphone_tinder_messages`;
TRUNCATE TABLE `smartphone_tinder_rating`;
TRUNCATE TABLE `smartphone_tor_messages`;
TRUNCATE TABLE `smartphone_tor_payments`;
TRUNCATE TABLE `smartphone_twitter_followers`;
TRUNCATE TABLE `smartphone_twitter_likes`;
TRUNCATE TABLE `smartphone_twitter_profiles`;
TRUNCATE TABLE `smartphone_twitter_tweets`;
TRUNCATE TABLE `smartphone_uber_trips`;
TRUNCATE TABLE `smartphone_weazel`;
TRUNCATE TABLE `smartphone_whatsapp`;
TRUNCATE TABLE `smartphone_whatsapp_channels`;
TRUNCATE TABLE `smartphone_whatsapp_groups`;
TRUNCATE TABLE `smartphone_whatsapp_messages`;

SET FOREIGN_KEY_CHECKS = 1;
