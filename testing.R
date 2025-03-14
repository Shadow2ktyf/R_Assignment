# read file
raw_genotypes <- read_tsv("fang_et_al_genotypes.txt")
raw_snp_position <- read_tsv("snp_position.txt")

# delete irrelevant columns
genotypes <- raw_genotypes %>% select(-JG_OTU)
snp_position <- raw_snp_position %>% select(SNP_ID, Chromosome, Position)

# separate groups maize and teosinte
genotypes_maize <- genotypes %>% 
  filter(Group %in% c("ZMMIL", "ZMMLR", "ZMMMR")) 

genotypes_teosinte <- genotypes %>% 
  filter(Group %in% c("ZMPBA", "ZMPIL", "ZMPJA"))


# transpose data set and adjust rows and headers
genotypes_maize_t <- genotypes_maize %>%
  t() %>%
  as.data.frame() %>%
  slice(-2) %>%
  mutate(Sample_ID = rownames(.)) %>%
  relocate(Sample_ID) %>%
  { colnames(.) <- .[1, ]; . } %>%
  slice(-1) %>%
  mutate(across(everything(), as.character)) %>%
  mutate(across(-1, as.factor))

rownames(genotypes_maize_t) <- NULL

genotypes_teosinte_t <- genotypes_teosinte %>%
  t() %>%
  as.data.frame() %>%
  slice(-2) %>%
  mutate(Sample_ID = rownames(.)) %>%
  relocate(Sample_ID) %>%
  { colnames(.) <- .[1, ]; . } %>%
  slice(-1) %>%
  mutate(across(everything(), as.character)) %>%
  mutate(across(-1, as.factor))

rownames(genotypes_teosinte_t) <- NULL

# joint snp and genotypes
joint_snp_maize <- snp_position %>%
  bind_cols(genotypes_maize_t[, -1])

joint_snp_teosinte <- snp_position %>% 
  bind_cols(genotypes_teosinte_t[, -1])


# maize increase file generate
maize_chromosome_increase <- function(chr) {
  joint_snp_maize %>%
    filter(Chromosome == chr) %>%
    mutate(Numeric_Position = suppressWarnings(as.numeric(Position))) %>%  
    arrange(is.na(Numeric_Position), Numeric_Position) %>%  
    select(-Numeric_Position) %>%
    write_tsv(paste0("maize_data/maize_chrom", chr, "_increase.txt"))
}

lapply(1:10, maize_chromosome_increase)

# maize decrease file generate
maize_chromosome_decrease <- function(chr) {
  joint_snp_maize %>%
    filter(Chromosome == chr) %>%
    mutate(Numeric_Position = suppressWarnings(as.numeric(Position))) %>%  
    arrange(is.na(Numeric_Position), desc(Numeric_Position)) %>%  
    select(-Numeric_Position) %>%
    mutate(across(4:ncol(.), ~ ifelse(. == "?/?", "-/-", .))) %>%  
    write_tsv(paste0("maize_data/maize_chrom", chr, "_decrease.txt"))
}

lapply(1:10, maize_chromosome_decrease)


# teosinte increase file generate
teosinte_chromosome_increase <- function(chr) {
  joint_snp_teosinte %>%
    filter(Chromosome == chr) %>%
    mutate(Numeric_Position = suppressWarnings(as.numeric(Position))) %>%
    arrange(is.na(Numeric_Position), Numeric_Position) %>%
    select(-Numeric_Position) %>%
    write_tsv(paste0("teosinte_data/teosinte_chrom", chr, "_increase.txt"))
}

lapply(1:10, teosinte_chromosome_increase)

# teosinte decrease file generate
teosinte_chromosome_decrease <- function(chr) {
  joint_snp_teosinte %>%
    filter(Chromosome == chr) %>%
    mutate(Numeric_Position = suppressWarnings(as.numeric(Position))) %>%  # Convert only numeric values
    arrange(is.na(Numeric_Position), desc(Numeric_Position)) %>%  # Sort numerically, keep "unknown" & "multiple" at bottom
    select(-Numeric_Position) %>%  # Remove temporary numeric column
    mutate(across(4:ncol(.), ~ ifelse(. == "?/?", "-/-", .))) %>%  # Replace "?/?" with "-/-" from 4th column onwards
    write_tsv(paste0("teosinte_data/teosinte_chrom", chr, "_decrease.txt"))
}

lapply(1:10, teosinte_chromosome_decrease)




