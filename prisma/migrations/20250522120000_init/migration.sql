-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateTable
CREATE TABLE "Change" (
    "id" TEXT NOT NULL,
    "service" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "documentType" TEXT NOT NULL,
    "filename" TEXT,
    "commitSha" TEXT NOT NULL,
    "commitDate" TIMESTAMP(3) NOT NULL,
    "commitUrl" TEXT NOT NULL,
    "diffContent" TEXT NOT NULL,
    "diffSummary" TEXT,
    "processed" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isMinorChange" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Change_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LastCheck" (
    "id" TEXT NOT NULL,
    "repo" TEXT NOT NULL,
    "lastCommitSha" TEXT NOT NULL,
    "checkedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LastCheck_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Change_category_idx" ON "Change"("category");

-- CreateIndex
CREATE INDEX "Change_commitDate_idx" ON "Change"("commitDate");

-- CreateIndex
CREATE INDEX "Change_commitSha_idx" ON "Change"("commitSha");

-- CreateIndex
CREATE INDEX "Change_processed_idx" ON "Change"("processed");

-- CreateIndex
CREATE INDEX "Change_service_idx" ON "Change"("service");

-- CreateIndex
CREATE INDEX "Change_isMinorChange_idx" ON "Change"("isMinorChange");

-- CreateIndex
CREATE UNIQUE INDEX "LastCheck_repo_key" ON "LastCheck"("repo");

-- CreateIndex
CREATE INDEX "LastCheck_repo_idx" ON "LastCheck"("repo");
