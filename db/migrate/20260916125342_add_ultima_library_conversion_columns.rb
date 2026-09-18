class AddUltimaLibraryConversionColumns < ActiveRecord::Migration[8.1]
  def change
    add_column :useq_wafer, :application_type, :string, comment: "Ultima application type used"
    add_column :useq_wafer, :uga_primer, :string, comment: "UGA indexing primer (Forward/R1 side)"
    add_column :useq_wafer, :ugb_primer, :string, comment: "UGB indexing primer (Reverse/R2 side)"
    add_column :useq_wafer, :converted_illumina_tag_sequence, :string, comment: "Illumina tag sequence used"
    add_column :useq_wafer, :converted_illumina_tag2_sequence, :string, comment: "Illumina tag2 sequence used"
  end
end
