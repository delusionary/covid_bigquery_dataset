#standardSQL

-- Subtract the portions of each county that comprises Kansas City from the values for the county as a whole.
-- Where medians or percentages are considered, we leave those values untouched, assuming that aggregates
-- for the whole county are representative enough of the values for the non-KC portions.
CREATE OR REPLACE VIEW public.nyt_kc_mo_trimmed_counties
AS
SELECT
    county.state_fips_code as state_fips_code,
    CONCAT(county.state_fips_code, county.county_fips_code,"000000") as county_fips_code,
    CONCAT(county.state_fips_code, county.county_fips_code,"000000") as combined_fips_code,
    county.county_gnis_code,
    county.aff_geo_code,
    CAST(NULL as STRING) as geo_id,
    county.county_name,
    "Missouri" as state_name,
    "MO" as state_abbreviation,
    county.area_land_meters - acs.area_land_meters as area_land_meters,
    county.area_water_meters as area_water_meters,
    ST_Y(ST_CENTROID(ST_DIFFERENCE(county.county_geom,acs.blockgroup_geom))) as longitude,
    ST_Y(ST_CENTROID(ST_DIFFERENCE(county.county_geom,acs.blockgroup_geom))) as latitute,
    ST_DIFFERENCE(county.county_geom,acs.blockgroup_geom) as county_geom,
    county.nonfamily_households - acs.nonfamily_households as nonfamily_households,
    county.family_households - acs.family_households as family_households,
    county.median_year_structure_built as median_year_structure_built,
    county.rent_burden_not_computed - acs.rent_burden_not_computed as rent_burden_not_computed,
    county.rent_over_50_percent - acs.rent_over_50_percent as rent_over_50_percent,
    county.rent_40_to_50_percent - acs.rent_40_to_50_percent as rent_40_to_50_percent,
    county.rent_35_to_40_percent - acs.rent_35_to_40_percent as rent_35_to_40_percent,
    county.rent_30_to_35_percent - acs.rent_30_to_35_percent as rent_30_to_35_percent,
    county.rent_25_to_30_percent - acs.rent_25_to_30_percent as rent_25_to_30_percent,
    county.rent_20_to_25_percent - acs.rent_20_to_25_percent as rent_20_to_25_percent,
    county.rent_15_to_20_percent - acs.rent_15_to_20_percent as rent_15_to_20_percent,
    county.rent_10_to_15_percent - acs.rent_10_to_15_percent as rent_10_to_15_percent,
    county.rent_under_10_percent - acs.rent_under_10_percent as rent_under_10_percent,
    county.total_pop - acs.total_pop as total_pop,
    county.male_pop - acs.male_pop as male_pop,
    county.female_pop - acs.female_pop as female_pop,
    county.median_age as median_age,
    county.white_pop - acs.white_pop as white_pop,
    county.black_pop - acs.black_pop as black_pop,
    county.asian_pop - acs.asian_pop as asian_pop,
    county.hispanic_pop - acs.hispanic_pop as hispanic_pop,
    county.amerindian_pop - acs.amerindian_pop as amerindian_pop,
    county.other_race_pop - acs.other_race_pop as other_race_pop,
    county.two_or_more_races_pop - acs.two_or_more_races_pop as two_or_more_races_pop,
    county.not_hispanic_pop - acs.not_hispanic_pop as not_hispanic_pop,
    county.commuters_by_public_transportation - acs.commuters_by_public_transportation as commuters_by_public_transportation,
    county.households - acs.households as households,
    county.median_income as median_income,
    county.income_per_capita as income_per_capita,
    county.housing_units - acs.housing_units as housing_units,
    county.vacant_housing_units - acs.vacant_housing_units as vacant_housing_units,
    county.vacant_housing_units_for_rent - acs.vacant_housing_units_for_rent as vacant_housing_units_for_rent,
    county.vacant_housing_units_for_sale - acs.vacant_housing_units_for_sale as vacant_housing_units_for_sale,
    county.median_rent as median_rent,
    county.percent_income_spent_on_rent - acs.percent_income_spent_on_rent as percent_income_spent_on_rent,
    county.owner_occupied_housing_units - acs.owner_occupied_housing_units as owner_occupied_housing_units,
    county.million_dollar_housing_units - acs.million_dollar_housing_units as million_dollar_housing_units,
    county.mortgaged_housing_units - acs.mortgaged_housing_units as mortgaged_housing_units,
    county.families_with_young_children - acs.families_with_young_children as families_with_young_children,
    county.two_parent_families_with_young_children - acs.two_parent_families_with_young_children as two_parent_families_with_young_children,
    county.two_parents_in_labor_force_families_with_young_children - acs.two_parents_in_labor_force_families_with_young_children as two_parents_in_labor_force_families_with_young_children,
    county.two_parents_father_in_labor_force_families_with_young_children - acs.two_parents_father_in_labor_force_families_with_young_children as two_parents_father_in_labor_force_families_with_young_children,
    county.two_parents_mother_in_labor_force_families_with_young_children - acs.two_parents_mother_in_labor_force_families_with_young_children as two_parents_mother_in_labor_force_families_with_young_children,
    county.two_parents_not_in_labor_force_families_with_young_children - acs.two_parents_not_in_labor_force_families_with_young_children as two_parents_not_in_labor_force_families_with_young_children,
    county.one_parent_families_with_young_children - acs.one_parent_families_with_young_children as one_parent_families_with_young_children,
    county.father_one_parent_families_with_young_children - acs.father_one_parent_families_with_young_children as father_one_parent_families_with_young_children,
    county.father_in_labor_force_one_parent_families_with_young_children - acs.father_in_labor_force_one_parent_families_with_young_children as father_in_labor_force_one_parent_families_with_young_children,
    county.commute_10_14_mins - acs.commute_10_14_mins as commute_10_14_mins,
    county.commute_15_19_mins - acs.commute_15_19_mins as commute_15_19_mins,
    county.commute_20_24_mins - acs.commute_20_24_mins as commute_20_24_mins,
    county.commute_25_29_mins - acs.commute_25_29_mins as commute_25_29_mins,
    county.commute_30_34_mins - acs.commute_30_34_mins as commute_30_34_mins,
    county.commute_45_59_mins - acs.commute_45_59_mins as commute_45_59_mins,
    county.aggregate_travel_time_to_work - acs.aggregate_travel_time_to_work as aggregate_travel_time_to_work,
    county.income_less_10000 - acs.income_less_10000 as income_less_10000,
    county.income_10000_14999 - acs.income_10000_14999 as income_10000_14999,
    county.income_15000_19999 - acs.income_15000_19999 as income_15000_19999,
    county.income_20000_24999 - acs.income_20000_24999 as income_20000_24999,
    county.income_25000_29999 - acs.income_25000_29999 as income_25000_29999,
    county.income_30000_34999 - acs.income_30000_34999 as income_30000_34999,
    county.income_35000_39999 - acs.income_35000_39999 as income_35000_39999,
    county.income_40000_44999 - acs.income_40000_44999 as income_40000_44999,
    county.income_45000_49999 - acs.income_45000_49999 as income_45000_49999,
    county.income_50000_59999 - acs.income_50000_59999 as income_50000_59999,
    county.income_60000_74999 - acs.income_60000_74999 as income_60000_74999,
    county.income_75000_99999 - acs.income_75000_99999 as income_75000_99999,
    county.income_100000_124999 - acs.income_100000_124999 as income_100000_124999,
    county.income_125000_149999 - acs.income_125000_149999 as income_125000_149999,
    county.income_150000_199999 - acs.income_150000_199999 as income_150000_199999,
    county.income_200000_or_more - acs.income_200000_or_more as income_200000_or_more,
    county.renter_occupied_housing_units_paying_cash_median_gross_rent as renter_occupied_housing_units_paying_cash_median_gross_rent,
    county.owner_occupied_housing_units_lower_value_quartile as owner_occupied_housing_units_lower_value_quartile,
    county.owner_occupied_housing_units_median_value as owner_occupied_housing_units_median_value,
    county.owner_occupied_housing_units_upper_value_quartile as owner_occupied_housing_units_upper_value_quartile,
    county.married_households - acs.married_households as married_households,
    county.occupied_housing_units - acs.occupied_housing_units as occupied_housing_units,
    county.housing_units_renter_occupied - acs.housing_units_renter_occupied as housing_units_renter_occupied,
    county.dwellings_1_units_detached - acs.dwellings_1_units_detached as dwellings_1_units_detached,
    county.dwellings_1_units_attached - acs.dwellings_1_units_attached as dwellings_1_units_attached,
    county.dwellings_2_units - acs.dwellings_2_units as dwellings_2_units,
    county.dwellings_3_to_4_units - acs.dwellings_3_to_4_units as dwellings_3_to_4_units,
    county.dwellings_5_to_9_units - acs.dwellings_5_to_9_units as dwellings_5_to_9_units,
    county.dwellings_10_to_19_units - acs.dwellings_10_to_19_units as dwellings_10_to_19_units,
    county.dwellings_20_to_49_units - acs.dwellings_20_to_49_units as dwellings_20_to_49_units,
    county.dwellings_50_or_more_units - acs.dwellings_50_or_more_units as dwellings_50_or_more_units,
    county.mobile_homes - acs.mobile_homes as mobile_homes,
    county.housing_built_2005_or_later - acs.housing_built_2005_or_later as housing_built_2005_or_later,
    county.housing_built_2000_to_2004 - acs.housing_built_2000_to_2004 as housing_built_2000_to_2004,
    county.housing_built_1939_or_earlier - acs.housing_built_1939_or_earlier as housing_built_1939_or_earlier,
    county.male_under_5 - acs.male_under_5 as male_under_5,
    county.male_5_to_9 - acs.male_5_to_9 as male_5_to_9,
    county.male_10_to_14 - acs.male_10_to_14 as male_10_to_14,
    county.male_15_to_17 - acs.male_15_to_17 as male_15_to_17,
    county.male_18_to_19 - acs.male_18_to_19 as male_18_to_19,
    county.male_20 - acs.male_20 as male_20,
    county.male_21 - acs.male_21 as male_21,
    county.male_22_to_24 - acs.male_22_to_24 as male_22_to_24,
    county.male_25_to_29 - acs.male_25_to_29 as male_25_to_29,
    county.male_30_to_34 - acs.male_30_to_34 as male_30_to_34,
    county.male_35_to_39 - acs.male_35_to_39 as male_35_to_39,
    county.male_40_to_44 - acs.male_40_to_44 as male_40_to_44,
    county.male_45_to_49 - acs.male_45_to_49 as male_45_to_49,
    county.male_50_to_54 - acs.male_50_to_54 as male_50_to_54,
    county.male_55_to_59 - acs.male_55_to_59 as male_55_to_59,
    NULL as male_60_61,
    NULL as male_62_64,
    county.male_65_to_66 - acs.male_65_to_66 as male_65_to_66,
    county.male_67_to_69 - acs.male_67_to_69 as male_67_to_69,
    county.male_70_to_74 - acs.male_70_to_74 as male_70_to_74,
    county.male_75_to_79 - acs.male_75_to_79 as male_75_to_79,
    county.male_80_to_84 - acs.male_80_to_84 as male_80_to_84,
    county.male_85_and_over - acs.male_85_and_over as male_85_and_over,
    county.female_under_5 - acs.female_under_5 as female_under_5,
    county.female_5_to_9 - acs.female_5_to_9 as female_5_to_9,
    county.female_10_to_14 - acs.female_10_to_14 as female_10_to_14,
    county.female_15_to_17 - acs.female_15_to_17 as female_15_to_17,
    county.female_18_to_19 - acs.female_18_to_19 as female_18_to_19,
    county.female_20 - acs.female_20 as female_20,
    county.female_21 - acs.female_21 as female_21,
    county.female_22_to_24 - acs.female_22_to_24 as female_22_to_24,
    county.female_25_to_29 - acs.female_25_to_29 as female_25_to_29,
    county.female_30_to_34 - acs.female_30_to_34 as female_30_to_34,
    county.female_35_to_39 - acs.female_35_to_39 as female_35_to_39,
    county.female_40_to_44 - acs.female_40_to_44 as female_40_to_44,
    county.female_45_to_49 - acs.female_45_to_49 as female_45_to_49,
    county.female_50_to_54 - acs.female_50_to_54 as female_50_to_54,
    county.female_55_to_59 - acs.female_55_to_59 as female_55_to_59,
    county.female_60_to_61 - acs.female_60_to_61 as female_60_to_61,
    county.female_62_to_64 - acs.female_62_to_64 as female_62_to_64,
    county.female_65_to_66 - acs.female_65_to_66 as female_65_to_66,
    county.female_67_to_69 - acs.female_67_to_69 as female_67_to_69,
    county.female_70_to_74 - acs.female_70_to_74 as female_70_to_74,
    county.female_75_to_79 - acs.female_75_to_79 as female_75_to_79,
    county.female_80_to_84 - acs.female_80_to_84 as female_80_to_84,
    county.female_85_and_over - acs.female_85_and_over as female_85_and_over,
    county.white_including_hispanic - acs.white_including_hispanic as white_including_hispanic,
    county.black_including_hispanic - acs.black_including_hispanic as black_including_hispanic,
    county.amerindian_including_hispanic - acs.amerindian_including_hispanic as amerindian_including_hispanic,
    county.asian_including_hispanic - acs.asian_including_hispanic as asian_including_hispanic,
    county.commute_5_9_mins - acs.commute_5_9_mins as commute_5_9_mins,
    county.commute_35_39_mins - acs.commute_35_39_mins as commute_35_39_mins,
    county.commute_40_44_mins - acs.commute_40_44_mins as commute_40_44_mins,
    county.commute_60_89_mins - acs.commute_60_89_mins as commute_60_89_mins,
    county.commute_90_more_mins - acs.commute_90_more_mins as commute_90_more_mins,
    county.households_retirement_income - acs.households_retirement_income as households_retirement_income,
    county.armed_forces - acs.armed_forces as armed_forces,
    county.civilian_labor_force - acs.civilian_labor_force as civilian_labor_force,
    county.employed_pop - acs.employed_pop as employed_pop,
    county.unemployed_pop - acs.unemployed_pop as unemployed_pop,
    county.not_in_labor_force - acs.not_in_labor_force as not_in_labor_force,
    county.pop_16_over - acs.pop_16_over as pop_16_over,
    county.pop_in_labor_force - acs.pop_in_labor_force as pop_in_labor_force,
    NULL AS asian_male_45_54,
    NULL AS asian_male_55_64,
    NULL AS black_male_45_54,
    NULL AS black_male_55_64,
    NULL AS hispanic_male_45_54,
    NULL AS hispanic_male_55_64,
    NULL AS white_male_45_54,
    NULL AS white_male_55_64,
    NULL AS bachelors_degree_2,
    NULL AS bachelors_degree_or_higher_25_64,
    NULL AS children,
    NULL AS children_in_single_female_hh,
    NULL AS commuters_by_bus,
    NULL AS commuters_by_car_truck_van,
    NULL AS commuters_by_carpool,
    NULL AS commuters_by_subway_or_elevated,
    NULL AS commuters_drove_alone,
    NULL AS different_house_year_ago_different_city,
    NULL AS different_house_year_ago_same_city,
    NULL AS employed_agriculture_forestry_fishing_hunting_mining,
    NULL AS employed_arts_entertainment_recreation_accommodation_food,
    NULL AS employed_construction,
    NULL AS employed_education_health_social,
    NULL AS employed_finance_insurance_real_estate,
    NULL AS employed_information,
    NULL AS employed_manufacturing,
    NULL AS employed_other_services_not_public_admin,
    NULL AS employed_public_administration,
    NULL AS employed_retail_trade,
    NULL AS employed_science_management_admin_waste,
    NULL AS employed_transportation_warehousing_utilities,
    NULL AS employed_wholesale_trade,
    NULL AS female_female_households,
    NULL AS four_more_cars,
    NULL AS gini_index,
    NULL AS graduate_professional_degree,
    NULL AS group_quarters,
    NULL AS high_school_including_ged,
    NULL AS households_public_asst_or_food_stamps,
    NULL AS in_grades_1_to_4,
    NULL AS in_grades_5_to_8,
    NULL AS in_grades_9_to_12,
    NULL AS in_school,
    NULL AS in_undergrad_college,
    NULL AS less_than_high_school_graduate,
    NULL AS male_45_64_associates_degree,
    NULL AS male_45_64_bachelors_degree,
    NULL AS male_45_64_graduate_degree,
    NULL AS male_45_64_less_than_9_grade,
    NULL AS male_45_64_grade_9_12,
    NULL AS male_45_64_high_school,
    NULL AS male_45_64_some_college,
    NULL AS male_45_to_64,
    NULL AS male_male_households,
    NULL AS management_business_sci_arts_employed,
    NULL AS no_car,
    NULL AS no_cars,
    NULL AS not_us_citizen_pop,
    NULL AS occupation_management_arts,
    NULL AS occupation_natural_resources_construction_maintenance,
    NULL AS occupation_production_transportation_material,
    NULL AS occupation_sales_office,
    NULL AS occupation_services,
    NULL AS one_car,
    NULL AS two_cars,
    NULL AS three_cars,
    NULL AS pop_25_64,
    NULL AS pop_determined_poverty_status,
    NULL AS population_1_year_and_over,
    NULL AS population_3_years_over,
    NULL AS poverty,
    NULL AS sales_office_employed,
    NULL AS some_college_and_associates_degree,
    NULL AS walked_to_work,
    NULL AS worked_at_home,
    NULL AS workers_16_and_over,
    county.associates_degree - acs.associates_degree as associates_degree,
    county.bachelors_degree - acs.bachelors_degree as bachelors_degree,
    county.high_school_diploma - acs.high_school_diploma as high_school_diploma,
    county.less_one_year_college - acs.less_one_year_college as less_one_year_college,
    county.masters_degree - acs.masters_degree as masters_degree,
    county.one_year_more_college - acs.one_year_more_college as one_year_more_college,
    county.pop_25_years_over - acs.pop_25_years_over as pop_25_years_over,
    county.commute_35_44_mins - acs.commute_35_44_mins as commute_35_44_mins,
    county.commute_60_more_mins - acs.commute_60_more_mins as commute_60_more_mins,
    county.commute_less_10_mins - acs.commute_less_10_mins as commute_less_10_mins,
    county.commuters_16_over - acs.commuters_16_over as commuters_16_over,
    NULL AS hispanic_any_race,
    NULL AS pop_5_years_over,
    NULL AS speak_only_english_at_home,
    NULL AS speak_spanish_at_home,
    NULL AS speak_spanish_at_home_low_english,
    NULL AS pop_15_and_over,
    NULL AS pop_never_married,
    NULL AS pop_now_married,
    NULL AS pop_separated,
    NULL AS pop_widowed,
    NULL AS pop_divorced,
    county.do_date as do_date,
    county.state,
    county.county,
    county.fips,
    county.trump16*fraction.fraction_kc_pop as trump16,
    county.clinton16*fraction.fraction_kc_pop as clinton16,
    county.otherpres16*fraction.fraction_kc_pop as otherpres16,
    county.romney12*fraction.fraction_kc_pop as romney12,
    county.obama12*fraction.fraction_kc_pop as obama12,
    county.otherpres12*fraction.fraction_kc_pop as otherpres12,
    county.demsen16*fraction.fraction_kc_pop as demsen16,
    county.repsen16*fraction.fraction_kc_pop as repsen16,
    county.othersen16*fraction.fraction_kc_pop as othersen16,
    county.demhouse16*fraction.fraction_kc_pop as demhouse16,
    county.rephouse16*fraction.fraction_kc_pop as rephouse16,
    county.otherhouse16*fraction.fraction_kc_pop as otherhouse16,
    county.demgov16*fraction.fraction_kc_pop as demgov16,
    county.repgov16*fraction.fraction_kc_pop as repgov16,
    county.othergov16*fraction.fraction_kc_pop as othergov16,
    county.repgov14*fraction.fraction_kc_pop as repgov14,
    county.demgov14*fraction.fraction_kc_pop as demgov14,
    county.othergov14*fraction.fraction_kc_pop as othergov14,
    county.total_population*fraction.fraction_kc_pop as total_population,
    county.cvap*fraction.fraction_kc_pop as cvap,
    county.white_pct,
    county.black_pct,
    county.hispanic_pct,
    county.nonwhite_pct,
    county.foreignborn_pct,
    county.female_pct,
    county.age29andunder_pct,
    county.age65andolder_pct,
    county.median_hh_inc,
    county.clf_unemploy_pct,
    county.lesshs_pct,
    county.lesscollege_pct,
    county.lesshs_whites_pct,
    county.lesscollege_whites_pct,
    county.rural_pct,
    county.ruralurban_cc as ruralurban_cc
FROM `covid-project-275201`.public.nyt_kcmo_agg_bg_by_county acs
    LEFT JOIN `covid-project-275201`.public.county_area_acs county on county.county_fips_code = acs.county_fips_code and acs.state_fips_code=county.state_fips_code
    LEFT JOIN `covid-project-275201`.public.nyt_kcmo_county_fractions fraction ON county.county_fips_code=fraction.county_fips_code;

#    `bigquery-public-data.utility_us.us_county_area` county ON county.geo_id = acs.geo_id
#    LEFT JOIN `bigquery-public-data.utility_us.us_states_area` states ON county.state_fips_code = states.state_fips_code
#    LEFT JOIN `bigquery-public-data.census_bureau_acs.county_2017_5yr` county_acs on county.geo_id=county_acs.geo_id
#    LEFT JOIN `covid-project-275201`.public.nyt_kcmo_county_fractions fraction ON county.county_fips_code=fraction.county_fips_code
#    LEFT JOIN `covid-project-275201`.public.election_context_2018 election ON CONCAT(county.state_fips_code, county.county_fips_code) = CAST(election.fips as string);