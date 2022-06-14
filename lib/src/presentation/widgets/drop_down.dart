import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:flutter/material.dart';

class DropDown<T> extends StatefulWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final bool hintIsVisible;
  final String? hint;
  final ValueChanged<T?>? onChanged;
  final Widget? prefixIcon;

  const DropDown(
      {Key? key,
      required this.value,
      required this.items,
      this.hintIsVisible = true,
      this.hint,
      required this.onChanged,
      this.prefixIcon})
      : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.hintIsVisible,
            child: Text(
              widget.hint ?? "",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Theme.of(context).hintColor),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: Dimens.space8),
            child: ButtonTheme(
              key: widget.key,
              alignedDropdown: true,
              padding: EdgeInsets.zero,
              child: DropdownButtonFormField(
                isDense: true,
                isExpanded: true,
                value: widget.value,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: widget.onChanged,
                items: widget.items,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  isDense: true,
                  isCollapsed: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: Dimens.space12),
                    child: widget.prefixIcon,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minHeight: Dimens.space24,
                    minWidth: Dimens.space24
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: Dimens.space12),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(Dimens.space4),
                    borderSide: const BorderSide(color: Palette.disable),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(Dimens.space4),
                    borderSide: const BorderSide(color: Palette.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(Dimens.space4),
                    borderSide: const BorderSide(color: Palette.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(Dimens.space4),
                    borderSide: const BorderSide(color: Palette.primary),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
