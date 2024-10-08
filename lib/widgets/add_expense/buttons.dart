part of "../widgets.dart";


class FormButtons extends StatelessWidget{
  const FormButtons({required this.cancelAction,required this.saveAction, super.key});

  final Function() cancelAction;
  final Function() saveAction;

  @override
  Widget build(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(onPressed: cancelAction, child: const Text("Cancel")),
        const SizedBox(width: 15,),
        ElevatedButton(onPressed: saveAction, child: const Text("Save"))
      ],
    );
  }


}
