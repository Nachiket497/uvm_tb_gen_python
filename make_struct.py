import os 

def make_struct( struct_name, signal_list):

    data = []
    data.append("typedef struct {")

    for sig in signal_list :
        data.append( "      " +sig + ";" )

    
    data.append("} "+ struct_name + "_s;")

    return data

def make_struct_file(cwd, agnt_name, agnt_data):

    struct_file_path = os.path.join(cwd, agnt_name + "_struct.sv") 

    with open(struct_file_path, 'w') as f:
        for data in agnt_data :
            for line in data :
                f.write(line + "\n")
            f.write("\n")


def make_struct_pkg(cwd, data):
    pkg_file = os.path.join(cwd, 'struct_pkg.sv')
    with open(pkg_file, 'w') as f:
        # loop over agnts and include and import all agnts pkgs
        
        f.write('package ' + 'struct_pkg;\n')
        for agnt in data.keys() :
            f.write(f'`include  "{agnt}_struct.sv"\n ')
        f.write('endpackage\n')    

    pkg_file = os.path.join(cwd, 'sequence_pkg.sv')
    with open(pkg_file, 'w') as f:
        # loop over agnts and include and import all agnts pkgs
        
        f.write('package ' + 'sequence_pkg;\n')
        for agnt in data.keys() :
            f.write(f'`include  "{agnt}_sequence.sv"\n ')
        f.write('endpackage\n')   

def get_input( cwd, input_file_path):

    ipf = open(input_file_path)
    data = {}
    lines = [line.strip() for line in ipf.readlines()]
    i = 0
    while i < len(lines):
        st = lines[i]
        st = st.split(" ")
        agnt_name = st[0]
        agnt_data = []
        data[agnt_name] = []
        for j in range(1, len(st), 2):
            struct_name = st[j]
            struct_sig_list = []
            for k in range(int(st[j+1])):
                i += 1
                struct_sig_list.append(lines[i])
            agnt_data.append(make_struct(struct_name, struct_sig_list))
            data[agnt_name].append(struct_name)
           
        make_struct_file(cwd, agnt_name, agnt_data )
        i += 1
    make_struct_pkg(cwd, data)
    print(data)
    return data
    
        

if __name__ == "__main__":
    cwd = os.getcwd()
    input_file = "input_file.txt"
    input_file_path = cwd + "/" +  input_file
    data = get_input(cwd, input_file_path)
    print(data)
