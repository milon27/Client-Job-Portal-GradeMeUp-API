-- CreateTable
CREATE TABLE `admin` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(40) NOT NULL,
    `email` VARCHAR(155) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `admin.email_unique`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `candidate` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(155) NOT NULL,
    `phone` VARCHAR(40) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `image_url` VARCHAR(191) NOT NULL,
    `gender` ENUM('MALE', 'FEMALE') NOT NULL DEFAULT 'MALE',
    `dob` DATETIME(3) NOT NULL,
    `country` VARCHAR(191) NOT NULL,
    `region` VARCHAR(191) NOT NULL,
    `full_address` VARCHAR(191) NOT NULL,
    `zip_code` VARCHAR(20) NOT NULL,
    `private` BOOLEAN NOT NULL DEFAULT false,
    `job_type` ENUM('FULL_TIME', 'PART_TIME', 'INTERNSHIP') NOT NULL DEFAULT 'FULL_TIME',
    `work_experience` ENUM('YR_1', 'YR_1_3', 'YR_3_5', 'YR_MORE_5', 'YR_MORE_10') NOT NULL DEFAULT 'YR_1',
    `work_area_radius` DOUBLE NOT NULL DEFAULT 10,
    `working_hour_per_week` DOUBLE NOT NULL DEFAULT 25,
    `salary_per_hour` DOUBLE NOT NULL DEFAULT 25,
    `salary_per_month` DOUBLE NOT NULL DEFAULT 2500,
    `availability_date` ENUM('IMMEDIATELY', 'MONTH_1_3', 'MONTH_3_6') NOT NULL DEFAULT 'IMMEDIATELY',
    `work_shift` ENUM('DAY', 'NIGHT') NOT NULL DEFAULT 'DAY',
    `certificate` ENUM('NONE', 'SECENDARY_SCHOOL', 'EXTENDED_SECENDARY_SCHOOL', 'HIGH_SECENDARY_SCHOOL', 'DIPLOMA', 'BACHELOR') NOT NULL DEFAULT 'HIGH_SECENDARY_SCHOOL',
    `other_certificate` VARCHAR(250) NOT NULL,
    `license` VARCHAR(250) NOT NULL,
    `it_skills` VARCHAR(250) NOT NULL,
    `expected_benefits` VARCHAR(250) NOT NULL,
    `current_employment` ENUM('STUDENT', 'FOREIGNERS', 'UNEMPLOYED', 'EMPLOYED') NOT NULL DEFAULT 'STUDENT',
    `job_profession_id` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `candidate.email_unique`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `language` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_profession` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `job_cat_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_candidate_language` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_candidate_language_AB_unique`(`A`, `B`),
    INDEX `_candidate_language_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `candidate` ADD FOREIGN KEY (`job_profession_id`) REFERENCES `job_profession`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `job_profession` ADD FOREIGN KEY (`job_cat_id`) REFERENCES `job_category`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_candidate_language` ADD FOREIGN KEY (`A`) REFERENCES `candidate`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_candidate_language` ADD FOREIGN KEY (`B`) REFERENCES `language`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
