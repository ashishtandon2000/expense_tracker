part of '../widgets.dart';

class FilterValues {
  static const amountHighToLow = 'Amount - High to Low';
  static const amountLowToHigh = 'Amount - Low to High';
  static const timeLatestFirst = 'Time - Latest First';
  static const timeOldestFirst = 'Time - Oldest First';
}

class Filters extends StatelessWidget {
  const Filters({super.key});

  void handleFilter(selection) {
    print("Selected $selection");
  }

  @override
  Widget build(context) {
    // If we were not using Singleton class for provider we could use this:
    // final myProvider = Provider.of<FinanceProvider>(context, listen: false);
    // But as we have build Provide class as singleton we can just directly call the instance of provider
    final myProvider = FinanceProvider.instance;
    return Row(
      children: [
        // Expanded(
        //   child: Padding(
        //     padding: const EdgeInsets.all(0.0),
        //
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: "Search...",
        //         prefixIcon: Icon(Icons.search),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(8),
        //           borderSide: BorderSide.none,
        //         ),
        //         filled: true,
        //         fillColor: Colors.grey[200],
        //       ),
        //       onChanged: (value) {
        //         // Optional: add a callback to handle search query changes
        //         print("Search query: $value");
        //       },
        //     ),
        //   ),
        // ),
        const Text("Sort By: "),
        DropdownMenu(
            width: 150,
            textStyle: const TextStyle(fontSize: 15),
            initialSelection: FilterValues.timeLatestFirst,
            onSelected: (selection) {
              if (selection != null) {
                myProvider.sortExpenses(selection);
              }
            },
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                label: "Latest first",
                value: FilterValues.timeLatestFirst,
              ),
              DropdownMenuEntry(
                label: "Oldest first",
                value: FilterValues.timeOldestFirst,
              ),
              DropdownMenuEntry(
                label: "Low to high",
                value: FilterValues.amountLowToHigh,
              ),
              DropdownMenuEntry(
                label: "High to low",
                value: FilterValues.amountHighToLow,
              ),
            ]),
      ],
    );
  }
}
