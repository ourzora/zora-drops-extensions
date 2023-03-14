from glob import glob
from os.path import splitext, basename
from re import match

base_uri = 'ipfs://bafybeic4jjwp3rbtuixq25pmiy5mh2fil2prkeliz5dsyxytqmr5dd2wre/'
extension = '.png'

layers = [] 

# bg layer
layers.append((glob('1 Backgroun*')[0], False))

# gives us layers 1 - 20
for n in range(4):
  offset = (n + 1) * 5
  i = offset

  layers.append((glob(f'{i} Body*')[0], True))
  layers.append((glob(f'{i+1} Accessories*')[0], True))
  layers.append((glob(f'{i+2} Head*')[0], False))
  layers.append((glob(f'{i+3} Expression*')[0], False))
  layers.append((glob(f'{i+4} Glasses*')[0], False))

layer_result = []

variant_size = 4

for layer, is_variant in layers:
  properties = []
  properties = glob(f'{layer}/*.png')
  prop_out = sorted([splitext(basename(p))[0] for p in properties])
  variants =[]
  if is_variant:
    for i in range(4):
      img_count = [prop for prop in prop_out if prop.startswith(f'{i+1}-')]
      start_index = prop_out.index(img_count[0])
      variants.append((start_index, len(img_count)))

  layer_result.append((layer, variants, prop_out))
  # print(layer, is_variant, len(prop_out))

def get_add_props(target_variable, props):
  items = [f"{target_variable}[{indx}] = \"{prop}\";" for indx, prop in enumerate(props)]
  return "\n".join(items)

def get_variant_props(target_variable, variants):
  items = [f"{target_variable}[{indx}] = INounsCoasterMetadataRendererTypes.VariantInfo({{startAt: {variant[0]}, count: {variant[1]}}});" for indx, variant in enumerate(variants)]
  return "\n".join(items)

def make_fn(layer, variants, props):
  result = match(r'^([0-9]+)', layer)
  layer_id = result[1]
  return f'''
    function addLayer{layer_id}(NounsCoasterMetadataRenderer renderer, address target) internal {{
      // {layer}
      INounsCoasterMetadataRendererTypes.VariantInfo[] memory variants = new INounsCoasterMetadataRendererTypes.VariantInfo[]({len(variants)});
      string[] memory items = new string[]({len(props)});
      {get_add_props('items', props)}
      {get_variant_props('variants', variants)}

      bytes memory data = abi.encode(items);

      VmSafe vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))));

      string[] memory inputs = new string[](3);
      inputs[0] = 'node';
      inputs[1] = 'script/nouns-coasters/deflate.js';
      inputs[2] = vm.toString(data);

      bytes memory compressedData = vm.ffi(inputs);

      address result = SSTORE2.write(compressedData);

      renderer.addLayer({{
        target: target,
        ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({{
          baseUri: "{base_uri}",
          extension: "{extension}"
        }}),
        decompressedSize: data.length,
        compressedDataAddress: result,
        count: items.length,
        property: "{layer}",
        variants: variants
      }});
    }}
  '''

def get_solidity_fn():
  functions = [make_fn(layer, variants, props) for (layer, variants, props) in layer_result]
  functions_str = "\n".join(functions)
  return f'''
  // SPDX-License-Identifier: MIT
  pragma solidity ^0.8.10;

  import {{NounsCoasterMetadataRenderer}} from "./NounsCoasterMetadataRenderer.sol";
  import {{SSTORE2}} from "../utils/SSTORE2.sol";
  import {{INounsCoasterMetadataRendererTypes}} from "../interfaces/INounsCoasterMetadataRendererTypes.sol";
  import {{VmSafe}} from "forge-std/Vm.sol";


  library CoasterHelper {{

    {functions_str}


  }}
  '''

print(get_solidity_fn())