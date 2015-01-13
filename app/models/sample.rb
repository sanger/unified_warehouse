class Sample < ActiveRecord::Base
  include ResourceTools
  include SingularResourceTools

  json do
    ignore(
      :new_name_format,
      :gc_content,
      :sample_manifest_id,
      :supplier_plate_id,
      :dna_source,
      :sample_tubes,
      :volume,
      :empty_supplier_sample_name,
      :updated_by_manifest
    )

    translate(
      :id                          => :id_sample_lims,
      :uuid                        => :uuid_sample_lims,
      :sample_common_name          => :common_name,
      :sample_description          => :description,
      :sample_ebi_accession_number => :accession_number,
      :sample_taxon_id             => :taxon_id,
      :sample_public_name          => :public_name,
      :sample_sra_hold             => :sample_visibility,
      :sample_strain_att           => :strain
    )
  end

end
