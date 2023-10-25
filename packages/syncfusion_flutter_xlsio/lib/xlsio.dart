// Support for creating Excel documents.
library xlsio;

import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_officecore/officecore.dart';
import 'package:xml/xml.dart';
part 'src/xlsio/autoFilters/auto_filter.dart';
part 'src/xlsio/autoFilters/autofilter_impl.dart';
part 'src/xlsio/autoFilters/autofiltercollection.dart';
part 'src/xlsio/autoFilters/autofiltercondition.dart';
part 'src/xlsio/autoFilters/autofilterconditon_impl.dart';
part 'src/xlsio/autoFilters/colorfilter.dart';
part 'src/xlsio/autoFilters/combination_filter.dart';
part 'src/xlsio/autoFilters/datetime_filter.dart';
part 'src/xlsio/autoFilters/dynamicfilter.dart';
part 'src/xlsio/autoFilters/filter.dart';
part 'src/xlsio/autoFilters/multiplefilter.dart';
part 'src/xlsio/autoFilters/text_filter.dart';
part 'src/xlsio/calculate/calc_engine.dart';
part 'src/xlsio/calculate/formula_info.dart';
part 'src/xlsio/calculate/sheet_family_item.dart';
part 'src/xlsio/calculate/stack.dart';
part 'src/xlsio/cell_styles/alignment.dart';
part 'src/xlsio/cell_styles/border.dart';
part 'src/xlsio/cell_styles/borders.dart';
part 'src/xlsio/cell_styles/cell_style.dart';
part 'src/xlsio/cell_styles/cell_style_wrapper.dart';
part 'src/xlsio/cell_styles/cell_style_xfs.dart';
part 'src/xlsio/cell_styles/cell_xfs.dart';
part 'src/xlsio/cell_styles/extend_compare_style.dart';
part 'src/xlsio/cell_styles/font.dart';
part 'src/xlsio/cell_styles/global_style.dart';
part 'src/xlsio/cell_styles/style.dart';
part 'src/xlsio/cell_styles/styles_collection.dart';
part 'src/xlsio/conditional_format/above_below_average/above_below_average.dart';
part 'src/xlsio/conditional_format/above_below_average/above_below_average_impl.dart';
part 'src/xlsio/conditional_format/above_below_average/above_below_average_wrapper.dart';
part 'src/xlsio/conditional_format/color_scale/color_scale.dart';
part 'src/xlsio/conditional_format/color_scale/color_scale_impl.dart';
part 'src/xlsio/conditional_format/color_scale/color_scale_wrapper.dart';
part 'src/xlsio/conditional_format/condformat_collection_wrapper.dart';
part 'src/xlsio/conditional_format/condformat_wrapper.dart';
part 'src/xlsio/conditional_format/condition_value.dart';
part 'src/xlsio/conditional_format/conditionalformat.dart';
part 'src/xlsio/conditional_format/conditionalformat_collections.dart';
part 'src/xlsio/conditional_format/conditionalformat_impl.dart';
part 'src/xlsio/conditional_format/data_bar/data_bar.dart';
part 'src/xlsio/conditional_format/data_bar/data_bar_impl.dart';
part 'src/xlsio/conditional_format/data_bar/data_bar_wrapper.dart';
part 'src/xlsio/conditional_format/icon_set/icon_set.dart';
part 'src/xlsio/conditional_format/icon_set/icon_set_impl.dart';
part 'src/xlsio/conditional_format/icon_set/icon_set_wrapper.dart';
part 'src/xlsio/conditional_format/top_bottom/top_bottom.dart';
part 'src/xlsio/conditional_format/top_bottom/top_bottom_impl.dart';
part 'src/xlsio/conditional_format/top_bottom/top_bottom_wrapper.dart';
part 'src/xlsio/datavalidation/datavalidation.dart';
part 'src/xlsio/datavalidation/datavalidation_collection.dart';
part 'src/xlsio/datavalidation/datavalidation_impl.dart';
part 'src/xlsio/datavalidation/datavalidation_table.dart';
part 'src/xlsio/datavalidation/datavalidation_wrapper.dart';
part 'src/xlsio/formats/format.dart';
part 'src/xlsio/formats/format_parser.dart';
part 'src/xlsio/formats/format_section.dart';
part 'src/xlsio/formats/format_section_collection.dart';
part 'src/xlsio/formats/format_tokens/am_pm_token.dart';
part 'src/xlsio/formats/format_tokens/character_token.dart';
part 'src/xlsio/formats/format_tokens/constants.dart';
part 'src/xlsio/formats/format_tokens/day_token.dart';
part 'src/xlsio/formats/format_tokens/decimal_point_token.dart';
part 'src/xlsio/formats/format_tokens/enums.dart';
part 'src/xlsio/formats/format_tokens/format_token_base.dart';
part 'src/xlsio/formats/format_tokens/fraction_token.dart';
part 'src/xlsio/formats/format_tokens/hour_24_token.dart';
part 'src/xlsio/formats/format_tokens/hour_token.dart';
part 'src/xlsio/formats/format_tokens/milli_second_token.dart';
part 'src/xlsio/formats/format_tokens/minute_token.dart';
part 'src/xlsio/formats/format_tokens/month_token.dart';
part 'src/xlsio/formats/format_tokens/second_token.dart';
part 'src/xlsio/formats/format_tokens/significant_digit_token.dart';
part 'src/xlsio/formats/format_tokens/unknown_token.dart';
part 'src/xlsio/formats/format_tokens/year_token.dart';
part 'src/xlsio/formats/formats_collection.dart';
part 'src/xlsio/general/autofit_manager.dart';
part 'src/xlsio/general/chart_helper.dart';
part 'src/xlsio/general/culture_info.dart';
part 'src/xlsio/general/enums.dart';
part 'src/xlsio/general/serialize_workbook.dart';
part 'src/xlsio/general/workbook.dart';
part 'src/xlsio/hyperlinks/hyperlink.dart';
part 'src/xlsio/hyperlinks/hyperlink_collection.dart';
part 'src/xlsio/images/picture.dart';
part 'src/xlsio/images/pictures_collection.dart';
part 'src/xlsio/named_range/names_coll.dart';
part 'src/xlsio/named_range/worksheet_names_collections.dart';
part 'src/xlsio/named_range/workbook_names_collections.dart';
part 'src/xlsio/named_range/name.dart';
part 'src/xlsio/named_range/name_impl.dart';
part 'src/xlsio/merged_cells/extend_style.dart';
part 'src/xlsio/merged_cells/merge_cells.dart';
part 'src/xlsio/merged_cells/merged_cell_collection.dart';
part 'src/xlsio/page_setup/page_setup.dart';
part 'src/xlsio/page_setup/page_setup_impl.dart';
part 'src/xlsio/range/column.dart';
part 'src/xlsio/range/column_collection.dart';
part 'src/xlsio/range/range.dart';
part 'src/xlsio/range/range_collection.dart';
part 'src/xlsio/range/row.dart';
part 'src/xlsio/range/row_collection.dart';
part 'src/xlsio/security/excel_sheet_protection.dart';
part 'src/xlsio/security/security_helper.dart';
part 'src/xlsio/table/exceltable.dart';
part 'src/xlsio/table/exceltable_impl.dart';
part 'src/xlsio/table/exceltablecollection.dart';
part 'src/xlsio/table/exceltablecolumn.dart';
part 'src/xlsio/table/exceltablecolumn_impl.dart';
part 'src/xlsio/table/table_serialization.dart';
part 'src/xlsio/worksheet/excel_data_row.dart';
part 'src/xlsio/worksheet/worksheet.dart';
part 'src/xlsio/worksheet/worksheet_collection.dart';
