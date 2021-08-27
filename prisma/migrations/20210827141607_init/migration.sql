-- CreateTable
CREATE TABLE `post` (
    `pid` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`pid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tag` (
    `tid` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`tid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `admin` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(155) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `admin.email_unique`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidate` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `image_url` VARCHAR(191) NOT NULL,
    `gender` ENUM('MALE', 'FEMALE') NOT NULL DEFAULT 'MALE',
    `dob` DATETIME(3) NOT NULL,
    `country` VARCHAR(191) NOT NULL,
    `region` VARCHAR(191) NOT NULL,
    `full_address` VARCHAR(191) NOT NULL,
    `zip_code` VARCHAR(20) NOT NULL,
    `job_type` ENUM('FULL_TIME', 'PART_TIME', 'INTERNSHIP') NOT NULL DEFAULT 'FULL_TIME',
    `job_cat_id` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `candidate.email_unique`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `language` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_post_tag` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_post_tag_AB_unique`(`A`, `B`),
    INDEX `_post_tag_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_candidate_language` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_candidate_language_AB_unique`(`A`, `B`),
    INDEX `_candidate_language_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `candidate` ADD FOREIGN KEY (`job_cat_id`) REFERENCES `job_category`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_post_tag` ADD FOREIGN KEY (`A`) REFERENCES `post`(`pid`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_post_tag` ADD FOREIGN KEY (`B`) REFERENCES `tag`(`tid`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_candidate_language` ADD FOREIGN KEY (`A`) REFERENCES `candidate`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_candidate_language` ADD FOREIGN KEY (`B`) REFERENCES `language`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
