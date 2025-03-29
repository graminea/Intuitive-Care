import zipfile

def extract_zip_file(zip_file_path, destination_directory):
    """
    Extrai o zip dos anexos.

    Parametros:
    path(str): Caminho do arquivo zip. (anexos.zip nesse caso expecifico)

    ele será extraido para o diretorio do programa para arquivos (/data).

    Returns:
    None
    """
    with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
        zip_ref.extractall(destination_directory)  # Extract all contents to the destination directory